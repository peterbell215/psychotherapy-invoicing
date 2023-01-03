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
    context 'when a new record is built with a nil value for hourly_charge' do
      subject { FactoryBot.build :client }

      it 'autofills the session_charge.' do
        expect(subject.default_session_charge).to eq Money.new(6000)
      end
    end

    context 'when a new record is created' do
      subject { Client.find_by(name: 'Test Client') }

      before(:context) { FactoryBot.create :client }

      it 'creates a child record session_charge with a default value' do
        expect(subject.default_session_charge).to eq Money.new(6000)
      end
    end
  end

  describe 'ensure no overlaps on session_charges' do
    context 'when non-overlapping session_charges exist' do
      subject { FactoryBot.build :client_with_session_charges }

      it 'passes validation' do
        expect(subject).to be_valid
      end
    end

    context 'when overlapping session_charges exist' do
      subject { FactoryBot.build :client_with_session_charges, gap: -5.days }

      it 'fails validation' do
        expect(subject).not_to be_valid
        expect(subject.errors[:session_charges].first).to eq "Session charge to 2023-06-01 overlaps with its successor"
      end
    end
  end
end
