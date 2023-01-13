require 'rails_helper'

RSpec.describe 'Doctor Show Page' do 

  let!(:sloan_hsp) { Hospital.create!(name: "Grey Sloan Memorial Hospital") }

  let!(:meredith) { sloan_hsp.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University") }
  let!(:miranda) { sloan_hsp.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University") }

  let!(:katie) { Patient.create!(name: "Katie Bryce", age: 24) }
  let!(:denny) { Patient.create!(name: "Denny Duquette", age: 39) }
  let!(:rebecca) { Patient.create!(name: "Rebecca Pope", age: 32) }
  let!(:zola) { Patient.create!(name: "Zola Shepherd", age: 2) }

  describe 'when I visit the doctor show page' do 
    it 'displays the doctor information' do 
      visit doctor_path(meredith)

      expect(page).to have_content(meredith.name)
      expect(page).to have_content("Specialty: #{meredith.specialty}")
      expect(page).to have_content("Education: #{meredith.university}")
    end

    it 'has the name of the hospital the doctor is working' do 
      visit doctor_path(meredith)

      expect(page).to have_content("Currently Working: Grey Sloan Memorial Hospital")
    end

    it 'shows all the patients the doctor has' do 
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

    describe 'delete patient' do 
      it 'has a button to remove a patient next to each patient' do 
        DoctorPatient.create!(doctor_id: meredith.id, patient_id: katie.id)
        DoctorPatient.create!(doctor_id: meredith.id, patient_id: denny.id)
        DoctorPatient.create!(doctor_id: meredith.id, patient_id: rebecca.id)
    
        visit doctor_path(meredith)
  
        within "#doctor_patient_#{katie.id}" do 
          expect(page).to have_button("Delete #{katie.name}")
        end
        
        within "#doctor_patient_#{denny.id}" do 
          expect(page).to have_button("Delete #{denny.name}")
        end

        within "#doctor_patient_#{rebecca.id}" do 
          expect(page).to have_button("Delete #{rebecca.name}")
        end
      end

      it 'will no longer show that patient on the doctor show page when delete button clicked' do 
        DoctorPatient.create!(doctor_id: meredith.id, patient_id: katie.id)
        DoctorPatient.create!(doctor_id: meredith.id, patient_id: denny.id)
        DoctorPatient.create!(doctor_id: meredith.id, patient_id: rebecca.id)
    
        visit doctor_path(meredith)

        expect(page).to have_content(rebecca.name)

        click_button "Delete #{rebecca.name}"

        expect(current_path).to eq doctor_path(meredith)
        expect(page).to_not have_content(rebecca.name)
      end

      it 'will still show the same patient if another doctor has been assigned to them' do 
        DoctorPatient.create!(doctor_id: meredith.id, patient_id: katie.id)
        DoctorPatient.create!(doctor_id: meredith.id, patient_id: denny.id)
        DoctorPatient.create!(doctor_id: meredith.id, patient_id: rebecca.id)
    
        DoctorPatient.create!(doctor_id: miranda.id, patient_id: rebecca.id)

        visit doctor_path(meredith)

        expect(page).to have_content(rebecca.name)

        click_button "Delete #{rebecca.name}"

        expect(current_path).to eq doctor_path(meredith)
        expect(page).to_not have_content(rebecca.name)

        visit doctor_path(miranda)

        expect(page).to have_content(rebecca.name)
      end
    end 
  end
end