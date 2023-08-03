class ExperimentOption < ApplicationRecord
  belongs_to :experiment

  validates :value, presence: true
  validates :percentage, presence: true, numericality: { inclusion: 0..100 }
end
