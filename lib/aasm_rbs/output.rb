# frozen_string_literal: true

module AasmRbs
  class Output
    attr_accessor :data

    def initialize(klass)
      superclass = klass.superclass == Object ? nil : " < #{klass.superclass}"
      self.data = "class #{klass}#{superclass}\n"
    end

    def add_state(state)
      self.data += "  def #{state}?: () -> bool\n"
    end

    def add_event(event)
      self.data += "  def #{event}: (*untyped) -> bool\n"
      self.data += "  def #{event}!: (*untyped) -> bool\n"
      self.data += "  def #{event}_without_validation!: (*untyped) -> bool\n"
    end

    def finalize
      self.data += "end\n"
    end
  end
end
