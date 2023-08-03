class Client < ApplicationRecord
  validates :device_token, uniqueness: true, presence: true

  has_many :client_settings
end
