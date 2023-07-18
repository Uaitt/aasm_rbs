# frozen_string_literal: true

require 'spec_helper'

require_relative '../../lib/aasm_rbs/output'
require_relative '../classes/job'
require_relative '../classes/user'

RSpec.describe AasmRbs::Output do
  subject(:output) { described_class.new(klass) }

  describe '#add_states' do
    context 'with a non ActiveRecord model' do
      let(:klass) { Job }
      let(:expected_rbs) do
        <<~RBS
          class Job
            STATE_SLEEPING: String
            STATE_RUNNING: String
            STATE_CLEANING: String

            def sleeping?: () -> bool
            def running?: () -> bool
            def cleaning?: () -> bool
          end
        RBS
      end

      it 'correctly adds the states signatures to the data' do
        states = klass.aasm.states.map(&:name)
        output.add_states(states)
        output.finalize
        expect(output.data).to eq(expected_rbs)
      end
    end

    context 'with an ActiveRecord model' do
      let(:klass) { User }
      let(:expected_rbs) do
        <<~RBS
          class User < ActiveRecord::Base
            STATE_PENDING: String
            STATE_APPROVED: String
            STATE_REJECTED: String

            def self.pending: () -> User::ActiveRecord_Relation
            def self.approved: () -> User::ActiveRecord_Relation
            def self.rejected: () -> User::ActiveRecord_Relation

            def pending?: () -> bool
            def approved?: () -> bool
            def rejected?: () -> bool
          end
        RBS
      end

      it 'correctly adds the states signatures to the data' do
        states = klass.aasm.states.map(&:name)
        output.add_states(states)
        output.finalize
        expect(output.data).to eq(expected_rbs)
      end
    end
  end

  describe '#add_events' do
    context 'with a non ActiveRecord model' do
      let(:klass) { Job }
      let(:expected_rbs) do
        <<~RBS
          class Job
            def run: (*untyped) -> bool
            def run!: (*untyped) -> bool
            def run_without_validation!: (*untyped) -> bool
            def may_run?: (*untyped) -> bool
            def clean: (*untyped) -> bool
            def clean!: (*untyped) -> bool
            def clean_without_validation!: (*untyped) -> bool
            def may_clean?: (*untyped) -> bool
            def sleep: (*untyped) -> bool
            def sleep!: (*untyped) -> bool
            def sleep_without_validation!: (*untyped) -> bool
            def may_sleep?: (*untyped) -> bool
          end
        RBS
      end

      it 'correctly adds the events signatures to the data' do
        events = klass.aasm.events.map(&:name)
        output.add_events(events)
        output.finalize
        expect(output.data).to eq(expected_rbs)
      end
    end

    context 'with an ActiveRecord model' do
      let(:klass) { User }
      let(:expected_rbs) do
        <<~RBS
          class User < ActiveRecord::Base
            def approve: (*untyped) -> bool
            def approve!: (*untyped) -> bool
            def approve_without_validation!: (*untyped) -> bool
            def may_approve?: (*untyped) -> bool
            def reject: (*untyped) -> bool
            def reject!: (*untyped) -> bool
            def reject_without_validation!: (*untyped) -> bool
            def may_reject?: (*untyped) -> bool
          end
        RBS
      end

      it 'correctly adds the events signatures to the data' do
        events = klass.aasm.events.map(&:name)
        output.add_events(events)
        output.finalize
        expect(output.data).to eq(expected_rbs)
      end
    end
  end
end
