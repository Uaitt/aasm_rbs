# frozen_string_literal: true

require_relative 'aasm_rbs/output'

module AasmRbs
  def self.run(klass_name)
    klass = Object.const_get(klass_name)
    states = klass.aasm.states.map(&:name)
    events = klass.aasm.events.map(&:name)

    output = Output.new(klass)
    output.add_states(states)
    output.new_line
    output.add_events(events)
    output.finalize
  end
end
