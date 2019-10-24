# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventPolicy do
  let(:event_owner) { FactoryBot.build(:user) }
  let(:another_user) { FactoryBot.build(:user) }

  let(:event) { FactoryBot.build(:event, user: event_owner) }

  # объект тестирования (политика)
  subject { EventPolicy }

  permissions :create? do
    it 'denied creating an event if the user is undefined' do
      expect(subject).not_to permit(nil, Event)
    end

    it 'grants access if the user is log in' do
      expect(subject).to permit(event_owner, Event)
    end
  end

  permissions :update?, :destroy? do
    it 'grants access if the user is event owner' do
      expect(subject).to permit(event_owner, event)
    end

    it 'denied access if the user is undefined' do
      expect(subject).not_to permit(nil, event)
    end

    it 'denied access if the user is not owner' do
      expect(subject).not_to permit(another_user, event)
    end
  end

  permissions :show? do
    it 'grants access to any visitor' do
      expect(subject).to permit(nil, event)
      expect(subject).to permit(event_owner, event)
      expect(subject).to permit(another_user, event)
    end
  end
end
