class ClientSetting < ApplicationRecord
  belongs_to :client

  # those two are not optional. but it removes n+1 on stage of population
  # if something will go wrong db will trigger an exception
  belongs_to :experiment, optional: true
  belongs_to :experiment_option, optional: true
end
