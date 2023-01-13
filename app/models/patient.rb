class Patient < ApplicationRecord 
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients 

  def self.adult_patients_sorted_alphabetically 
    self.where("age > 18").order(:name).distinct
  end
end