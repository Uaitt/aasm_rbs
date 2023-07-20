# frozen_string_literal: true

module AasmRbs
  class Output
    attr_reader :klass
    attr_accessor :data

    def initialize(klass)
      @klass = klass
      superclass = klass.superclass == Object ? nil : " < #{klass.superclass}"
      self.data = "class #{klass}#{superclass}\n"
    end

    def add_states(states)
      add_state_constants(states)
      create_scopes = klass.aasm.state_machine.config.create_scopes
      add_state_scopes(states) if klass.respond_to?(:aasm_create_scope) && create_scopes
      add_predicate_states_methods(states)
    end

    def add_events(events)
      events.each do |event|
        self.data += "  def #{event}: (*untyped) -> bool\n"
        self.data += "  def #{event}!: (*untyped) -> bool\n"
        self.data += "  def #{event}_without_validation!: (*untyped) -> bool\n"
        self.data += "  def may_#{event}?: (*untyped) -> bool\n"
      end
    end

    def new_line
      self.data += "\n"
    end

    def finalize
      self.data += "end\n"
    end

    private

    def add_state_constants(states)
      states.each { |state| self.data += "  STATE_#{state.upcase}: String\n" }
      self.data += "\n"
    end

    def add_state_scopes(states)
      states.each { |state| self.data += "  def self.#{state}: () -> #{klass}::ActiveRecord_Relation\n" }
      self.data += "\n"
    end

    def add_predicate_states_methods(states)
      states.each { |state| self.data += "  def #{state}?: () -> bool\n" }
    end
  end
end
