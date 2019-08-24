# frozen_string_literal: true

class Event < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :address, presence: true
  validates :datetime, presence: true
end
