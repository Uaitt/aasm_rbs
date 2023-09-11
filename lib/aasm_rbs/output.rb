# frozen_string_literal: true

module AasmRbs
  class Output
    attr_reader :data

    def initialize(klass)
      @klass = klass
      superclass = klass.superclass == Object ? nil : " < #{klass.superclass}"
      self.data = "class #{klass}#{superclass}\n"
    end

    def add_states(states, opts = {})
      add_state_constants(states)
      add_state_scopes(states) if opts[:scopes]
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

    def add_active_record_relation
      self.data += <<-RBS
  class ActiveRecord_Relation < ::ActiveRecord::Relation
    include GeneratedRelationMethods
    include _ActiveRecord_Relation[#{klass}, Integer]
    include Enumerable[#{klass}]
  end
      RBS
    end

    def new_line
      self.data += "\n"
    end

    def finalize
      self.data += "end\n"
    end

    private

    attr_reader :klass
    attr_writer :data

    def add_state_constants(states)
      states.each { |state| self.data += "  STATE_#{state.upcase}: String\n" }
      new_line
    end

    def add_state_scopes(states)
      states.each { |state| self.data += "  def self.#{state}: () -> ActiveRecord_Relation\n" }
      new_line
    end

    def add_predicate_states_methods(states)
      states.each { |state| self.data += "  def #{state}?: () -> bool\n" }
      new_line
    end
  end
end
