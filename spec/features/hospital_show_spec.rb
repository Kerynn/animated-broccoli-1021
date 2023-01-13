require 'rails_helper'

RSpec.describe 'Hospital Show Page' do 

  let!(:sloan_hsp) { Hospital.create!(name: "Grey Sloan Memorial Hospital") }

  let!(:meredith) { sloan_hsp.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University") }
  let!(:derek) { sloan_hsp.doctors.create!(name: "Derek McDreamy", specialty: "Attending Surgeon", university: "University of Pennsylvania") }
  let!(:miranda) { sloan_hsp.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University") }

  let!(:katie) { Patient.create!(name: "Katie Bryce", age: 24) }
  let!(:denny) { Patient.create!(name: "Denny Duquette", age: 39) }
  let!(:henry) { Patient.create!(name: "Henry Higgins", age: 17) }
  let!(:rebecca) { Patient.create!(name: "Rebecca Pope", age: 32) }
  let!(:zola) { Patient.create!(name: "Zola Shepherd", age: 2) }

  describe 'when I visit the hospital show page' do 
    it 'shows the hospital name' do 
      visit hospital_path(sloan_hsp)

      expect(page).to have_content(sloan_hsp.name)
    end

    it 'shows the names of all doctors at this hospital' do 
      visit hospital_path(sloan_hsp)

      expect(page).to have_content(meredith.name)
      expect(page).to have_content(miranda.name)
      expect(page).to have_content(derek.name)
    end

    # xit 'indicates number of patients associated with each doctor' do 
    #   DoctorPatient.create!(doctor_id: meredith.id, patient_id: katie.id)
    #   DoctorPatient.create!(doctor_id: meredith.id, patient_id: denny.id)
    #   DoctorPatient.create!(doctor_id: meredith.id, patient_id: henry.id)

    #   DoctorPatient.create!(doctor_id: derek.id, patient_id: denny.id)

    #   DoctorPatient.create!(doctor_id: miranda.id, patient_id: zola.id)
    #   DoctorPatient.create!(doctor_id: miranda.id, patient_id: rebecca.id)

    #   visit hospital_path(sloan_hsp)

    #   within "#case_load_#{meredith.id}" do 
    #     expect(page).to have_content("Number Patients: 3")
    #   end

    #   within "#case_load_#{derek.id}" do 
    #     expect(page).to have_content("Number Patients: 1")
    #   end

    #   within "#case_load_#{miranda.id}" do 
    #     expect(page).to have_content("Number Patients: 2")
    #   end
    # end

    # xit 'lists the doctors in order from most number of patients to least' do 

    # end
  end
end