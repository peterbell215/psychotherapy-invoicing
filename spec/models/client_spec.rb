# frozen_string_literal: true

require 'rails_helper'

describe 'Client' do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  describe 'FactoryBot' do
    subject { FactoryBot.build :client}

    it 'creates a sample item correctly' do
      expect(subject.name).to eq('Test Client')
    end
  end

  describe '#default_session_charge' do
    context 'when a new record is created with a nil value for hourly_charge' do
      subject { FactoryBot.create :client}

      it 'autofills the session_charge.' do
        expect(subject.default_session_charge).to eq Money.new(6000)
      end
    end
  end

  describe 'ensure no overlaps on session_charges' do
    context 'when non-overlapping session_charges exist' do
      subject { FactoryBot.create :client_with_session_charges }
      it 'passes validation' do
        expect(subject.valid?).to be_truthy
      end
    end
  end
end
