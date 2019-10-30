# frozen_string_literal: true

class Identity < ApplicationRecord
  belongs_to :user

  def self.find_identity(url, provider)
    where(url: url, provider: provider).first
  end
end
