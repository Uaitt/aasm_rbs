# frozen_string_literal: true

require 'aasm'
require_relative 'application_record'

class Refund < ApplicationRecord
  include AASM

  aasm column: :state, create_scopes: false do
    state :pending, initial: true
    state :processed
    state :failed

    event :process do
      transitions from: :pending, to: :processed
    end

    event :fail do
      transitions from: %i[pending processed], to: :failed
    end
  end
end
