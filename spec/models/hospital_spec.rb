require 'rails_helper'

RSpec.describe Hospital do
  it {should have_many :doctors}
  it { should have_many :patients }

  # describe 'class methods' do 
  #   describe 'sorted_patient_count' do 
  #     xit 'sorts the doctors of the hospital by patient count' do
  #       sloan_hsp = Hospital.create!(name: "Grey Sloan Memorial Hospital")
  #       meredith = sloan_hsp.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")
  #       derek = sloan_hsp.doctors.create!(name: "Derek McDreamy", specialty: "Attending Surgeon", university: "University of Pennsylvania")
  #       miranda = sloan_hsp.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University")

  #       katie = Patient.create!(name: "Katie Bryce", age: 24)
  #       denny = Patient.create!(name: "Denny Duquette", age: 39)
  #       henry = Patient.create!(name: "Henry Higgins", age: 17)
  #       rebecca = Patient.create!(name: "Rebecca Pope", age: 32)
  #       zola = Patient.create!(name: "Zola Shepherd", age: 2)

  #       DoctorPatient.create!(doctor_id: meredith.id, patient_id: katie.id)
  #       DoctorPatient.create!(doctor_id: meredith.id, patient_id: denny.id)
  #       DoctorPatient.create!(doctor_id: meredith.id, patient_id: henry.id)

  #       DoctorPatient.create!(doctor_id: derek.id, patient_id: denny.id)

  #       DoctorPatient.create!(doctor_id: miranda.id, patient_id: zola.id)
  #       DoctorPatient.create!(doctor_id: miranda.id, patient_id: rebecca.id)


  #       expect(Hospital.sorted_patient_count).to eq([meredith, miranda, derek])
  #     end 
  #   end
  # end
end
