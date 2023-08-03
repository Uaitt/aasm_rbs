# frozen_string_literal: true

require_relative 'aasm_rbs/output'

module AasmRbs
  def self.load_constants(klass_name)
    load './Rakefile' if File.exist?('./Rakefile')
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
      abort 'There was a problem loading the class file'
    end
  end

  def self.run(klass_name)
    klass = Object.const_get(klass_name)
    states = klass.aasm.states.map(&:name)
    events = klass.aasm.events.map(&:name)

    output = Output.new(klass)
    output.add_states(states)
    output.new_line
    output.add_events(events)
    output.finalize
  rescue StandardError
    print "aasm_rbs received an invalid class name."
  end
end
