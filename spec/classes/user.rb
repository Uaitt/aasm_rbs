# frozen_string_literal: true

require 'aasm'
require_relative 'application_record'

class User < ApplicationRecord
  include AASM

  aasm column: :state do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions from: :pending, to: :approved
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end
  end
end
