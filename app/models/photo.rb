# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  scope :first_six, -> { order(:created_at).limit(6) }
  scope :seven_and_all, -> { order(:created_at).offset(6) }

  validates :photo, presence: true

  mount_uploader :photo, PhotoUploader

  scope :persisted, -> { where 'id IS NOT NULL' }
end
