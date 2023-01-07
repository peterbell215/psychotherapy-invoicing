# frozen_string_literal: true

require 'rails_helper'

describe 'Client' do
  describe 'FactoryBot' do
    subject(:test_client) { build(:client) }

    it 'creates a sample item correctly' do
      expect(test_client.name).to eq('Test Client')
    end
  end

  describe '#current_rate' do
    context 'when a new record is built with a nil value for hourly_charge' do
      subject(:test_client) { build(:client) }

      it 'autofills the session_charge.' do
        expect(test_client.current_rate).to eq Money.new(6000)
      end
    end

    context 'when a new record is created with a nil value for hourly_charge' do
      before { create(:client) }

      let(:read_back_client) { Client.find_by(name: 'Test Client') }

      it 'creates a child record session_charge with a default value' do
        expect(read_back_client.current_rate).to eq Money.new(6000)
      end
    end
  end

  describe '#current_rate=' do
    context 'when a new client record is built with current_rate set' do
      subject(:test_client) { Client.new(current_rate: Money.new(7000)) }

      it 'creates a corresponding session_charge child' do
        expect(test_client.current_rate).to eq Money.new(7000)
      end
    end

    context 'when a new client record is created with current_rate set' do
      before { Client.create!(attributes_for(:client).merge(current_rate: Money.new(7000))) }

      let(:read_back_client) { Client.find_by(name: 'Test Client') }

      it 'creates a corresponding session_charge child' do
        expect(read_back_client.current_rate).to eq Money.new(7000)
      end
    end

    context 'when the same current_rate is set a 2nd time' do
      subject(:test_client) { Client.create!(attributes_for(:client).merge(current_rate: Money.new(7000))) }

      it 'does not do an update to the current session_charge record' do
        expect(test_client.current_session_charge).not_to have_changed
      end
    end
  end

  describe 'ensure no overlaps on session_charges' do
    context 'when non-overlapping session_charges exist' do
      subject(:test_client) { build(:client_with_session_charges) }

      it 'passes validation' do
        expect(test_client).to be_valid
      end
    end

    context 'when overlapping session_charges exist' do
      subject(:test_client) { build(:client_with_session_charges, gap: -5.days) }

      it 'fails validation' do
        expect(test_client).not_to be_valid
        expect(test_client.errors[:session_charges].first)
          .to eq 'Session charge to 2023-06-01 overlaps with its successor'
      end
    end
  end
end
