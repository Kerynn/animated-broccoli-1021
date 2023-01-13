require 'rails_helper'

RSpec.describe 'Doctor Show Page' do 
  describe 'when I visit the doctor show page' do 
    it 'displays the doctor information' do 
      sloan_hsp = Hospital.create!(name: "Grey Sloan Memorial Hospital")
      meredith = sloan_hsp.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")

      visit doctor_path(meredith)

      expect(page).to have_content(meredith.name)
      expect(page).to have_content("Specialty: #{meredith.specialty}")
      expect(page).to have_content("Education: #{meredith.university}")
    end

    it 'has the name of the hospital the doctor is working' do 
      sloan_hsp = Hospital.create!(name: "Grey Sloan Memorial Hospital")
      meredith = sloan_hsp.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")

      visit doctor_path(meredith)

      expect(page).to have_content("Currently Working: Grey Sloan Memorial Hospital")
    end

    it 'shows all the patients the doctor has' do 
      sloan_hsp = Hospital.create!(name: "Grey Sloan Memorial Hospital")
      meredith = sloan_hsp.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")
      miranda = sloan_hsp.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University")

      katie = Patient.create!(name: "Katie Bryce", age: 24)
      denny = Patient.create!(name: "Debby Duquette", age: 39)
      rebecca = Patient.create!(name: "Rebecca Pope", age: 32)
      zola = Patient.create!(name: "Zola Shepherd", age: 2)

      DoctorPatient.create!(doctor_id: meredith.id, patient_id: katie.id)
      DoctorPatient.create!(doctor_id: meredith.id, patient_id: denny.id)
      DoctorPatient.create!(doctor_id: meredith.id, patient_id: rebecca.id)

      DoctorPatient.create!(doctor_id: miranda.id, patient_id: zola.id)

      visit doctor_path(meredith)

      within "#patients" do 
        expect(page).to have_content(katie.name)
        expect(page).to have_content(denny.name)
        expect(page).to have_content(rebecca.name)
        expect(page).to_not have_content(zola.name)
      end
    end
  end
end