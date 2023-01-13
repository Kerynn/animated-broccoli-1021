require 'rails_helper'

RSpec.describe 'Patient Index Page' do 
  describe 'when I visit the patient index page' do 
    it 'only shows the unique names of the patients over 18 years old' do 
      sloan_hsp = Hospital.create!(name: "Grey Sloan Memorial Hospital")
      meredith = sloan_hsp.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")
      miranda = sloan_hsp.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University")
      derek = sloan_hsp.doctors.create!(name: "Derek McDreamy", specialty: "Attending Surgeon", university: "University of Pennsylvania")

      katie = Patient.create!(name: "Katie Bryce", age: 24)
      denny = Patient.create!(name: "Denny Duquette", age: 39)
      henry = Patient.create!(name: "Henry Higgins", age: 17)
      rebecca = Patient.create!(name: "Rebecca Pope", age: 32)
      zola = Patient.create!(name: "Zola Shepherd", age: 2)

      DoctorPatient.create!(doctor_id: meredith.id, patient_id: katie.id)
      DoctorPatient.create!(doctor_id: meredith.id, patient_id: denny.id)
      DoctorPatient.create!(doctor_id: meredith.id, patient_id: henry.id)

      DoctorPatient.create!(doctor_id: miranda.id, patient_id: zola.id)
      DoctorPatient.create!(doctor_id: miranda.id, patient_id: rebecca.id)
      DoctorPatient.create!(doctor_id: miranda.id, patient_id: katie.id)

      DoctorPatient.create!(doctor_id: derek.id, patient_id: denny.id)

      visit patients_path 

      expect(page).to have_content(katie.name, count: 1)
      expect(page).to have_content(denny.name, count: 1)
      expect(page).to have_content(rebecca.name, count: 1)
      expect(page).to_not have_content(zola.name)
      expect(page).to_not have_content(henry.name)
    end

    it 'lists the names in ascending alphabetical order' do 
      sloan_hsp = Hospital.create!(name: "Grey Sloan Memorial Hospital")
      meredith = sloan_hsp.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")
      miranda = sloan_hsp.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University")
      derek = sloan_hsp.doctors.create!(name: "Derek McDreamy", specialty: "Attending Surgeon", university: "University of Pennsylvania")

      katie = Patient.create!(name: "Katie Bryce", age: 24)
      denny = Patient.create!(name: "Denny Duquette", age: 39)
      henry = Patient.create!(name: "Henry Higgins", age: 17)
      rebecca = Patient.create!(name: "Rebecca Pope", age: 32)
      zola = Patient.create!(name: "Zola Shepherd", age: 2)

      DoctorPatient.create!(doctor_id: meredith.id, patient_id: katie.id)
      DoctorPatient.create!(doctor_id: meredith.id, patient_id: denny.id)
      DoctorPatient.create!(doctor_id: meredith.id, patient_id: henry.id)

      DoctorPatient.create!(doctor_id: miranda.id, patient_id: zola.id)
      DoctorPatient.create!(doctor_id: miranda.id, patient_id: rebecca.id)
      DoctorPatient.create!(doctor_id: miranda.id, patient_id: katie.id)

      DoctorPatient.create!(doctor_id: derek.id, patient_id: denny.id)

      visit patients_path 

      expect(denny.name).to appear_before(katie.name)
      expect(katie.name).to appear_before(rebecca.name)
    end
  end
end