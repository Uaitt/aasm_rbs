# frozen_string_literal: true

require 'spec_helper'

require_relative '../../lib/aasm_rbs/output'
require_relative '../classes/job'
require_relative '../classes/user'
require_relative '../classes/refund'

RSpec.describe AasmRbs::Output do
  subject(:output) { described_class.new(klass) }

  describe '#add_states' do
    let(:states) { klass.aasm.states.map(&:name) }

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

        RBS
      end

      it 'correctly adds the states signatures to the data' do
        output.add_states(states)
        expect(output.data).to eq(expected_rbs)
      end
    end

    context 'with an ActiveRecord model that disables AASM automatic scopes' do
      let(:klass) { Refund }
      let(:expected_rbs) do
        <<~RBS
          class Refund < ApplicationRecord
            STATE_PENDING: String
            STATE_PROCESSED: String
            STATE_FAILED: String

            def pending?: () -> bool
            def processed?: () -> bool
            def failed?: () -> bool

        RBS
      end

      it 'correctly adds the states signatures to the data' do
        output.add_states(states)
        expect(output.data).to eq(expected_rbs)
      end
    end

    context 'with an ActiveRecord model that enables AASM automatic scopes' do
      let(:klass) { User }
      let(:expected_rbs) do
        <<~RBS
          class User < ApplicationRecord
            STATE_PENDING: String
            STATE_APPROVED: String
            STATE_REJECTED: String

            def self.pending: () -> ActiveRecord_Relation
            def self.approved: () -> ActiveRecord_Relation
            def self.rejected: () -> ActiveRecord_Relation

            def pending?: () -> bool
            def approved?: () -> bool
            def rejected?: () -> bool

        RBS
      end

      it 'correctly adds the states signatures to the data' do
        output.add_states(states, scopes: true)
        expect(output.data).to eq(expected_rbs)
      end
    end
  end

  describe '#add_events' do
    let(:events) { klass.aasm.events.map(&:name) }

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
        RBS
      end

      it 'correctly adds the events signatures to the data' do
        output.add_events(events)
        expect(output.data).to eq(expected_rbs)
      end
    end

    context 'with an ActiveRecord model that disables AASM automatic scopes' do
      let(:klass) { Refund }
      let(:expected_rbs) do
        <<~RBS
          class Refund < ApplicationRecord
            def process: (*untyped) -> bool
            def process!: (*untyped) -> bool
            def process_without_validation!: (*untyped) -> bool
            def may_process?: (*untyped) -> bool
            def fail: (*untyped) -> bool
            def fail!: (*untyped) -> bool
            def fail_without_validation!: (*untyped) -> bool
            def may_fail?: (*untyped) -> bool
        RBS
      end

      it 'correctly adds the events signatures to the data' do
        output.add_events(events)
        expect(output.data).to eq(expected_rbs)
      end
    end

    context 'with an ActiveRecord model that enables AASM automatic scopes' do
      let(:klass) { User }
      let(:expected_rbs) do
        <<~RBS
          class User < ApplicationRecord
            def approve: (*untyped) -> bool
            def approve!: (*untyped) -> bool
            def approve_without_validation!: (*untyped) -> bool
            def may_approve?: (*untyped) -> bool
            def reject: (*untyped) -> bool
            def reject!: (*untyped) -> bool
            def reject_without_validation!: (*untyped) -> bool
            def may_reject?: (*untyped) -> bool
        RBS
      end

      it 'correctly adds the events signatures to the data' do
        events = klass.aasm.events.map(&:name)
        output.add_events(events)
        expect(output.data).to eq(expected_rbs)
      end
    end
  end

  describe "#add_active_record_relation" do
    let(:klass) { User }
    let(:expected_rbs) do
      <<~RBS
        class User < ApplicationRecord
          class ActiveRecord_Relation < ::ActiveRecord::Relation
            include GeneratedRelationMethods
            include _ActiveRecord_Relation[User, Integer]
            include Enumerable[User]
          end
      RBS
    end

    it "correctly adds the ActiveRecord_Relation signatures to the data" do
      output.add_active_record_relation
      expect(output.data).to eq(expected_rbs)
    end
  end
end
