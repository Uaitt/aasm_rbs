# frozen_string_literal: true

require_relative 'aasm_rbs/output'

module AasmRbs
  def self.load_constants(klass_name)
    load('./Rakefile') if File.exist?('./Rakefile')
    begin
      Rake::Task[:environment].invoke
    rescue StandardError
      nil
    end
    return if defined?(Rails)

    # not in a Rails project, load the file manually
    file = Dir.pwd + "/lib/#{klass_name.split('::').join('/').downcase}"
    begin
      require file
    rescue LoadError
      abort('There was a problem loading the class file.')
    end
  end

  def self.run(klass_name, opts = {})
    klass = Object.const_get(klass_name)
    output = Output.new(klass)

    states = klass.aasm.states.map(&:name)
    events = klass.aasm.events.map(&:name)

    create_scopes = klass.aasm.state_machine.config.create_scopes
    active_record_model = klass.respond_to?(:aasm_create_scope)
    opts[:scopes] = true if create_scopes && active_record_model

    output.add_states(states, opts)
    output.add_events(events)
    output.new_line && output.add_active_record_relation if opts[:scopes]
    output.finalize
  rescue StandardError
    abort('aasm_rbs received an invalid class name.')
  end
end
