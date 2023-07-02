# frozen_string_literal: true

require_relative 'aasm_rbs/output'

module AasmRbs
  def self.run(klass_name)
    klass = Object.const_get(klass_name)

    states = klass.aasm.states.map(&:name)
    events = klass.aasm.events.map(&:name)

    output = Output.new(klass)
    states.each { |state| output.add_state(state) }
    output.data += "\n"
    events.each { |event| output.add_event(event) }
    output.finalize
  end
end
