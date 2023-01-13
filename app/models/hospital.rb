class Hospital < ApplicationRecord
  has_many :doctors
  has_many :patients, through: :doctors

  # def self.sorted_patient_count
  # end
end
