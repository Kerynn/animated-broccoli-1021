require 'rails_helper'

RSpec.describe Patient, type: :model do 
  describe 'relationships' do 
    it { should have_many :doctor_patients }
    it { should have_many(:doctors).through(:doctor_patients) }
  end

  describe 'class methods' do 
    describe 'adult_patients_sorted_alphabetically' do 
      it 'sorts a distinct list of all the adult patients alphabetically by name' do 
        sloan_hsp = Hospital.create!(name: "Grey Sloan Memorial Hospital")
        meredith = sloan_hsp.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")
        miranda = sloan_hsp.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University")
  
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
  
        expect(Patient.adult_patients_sorted_alphabetically).to eq([denny, katie, rebecca])
      end
    end
  end
end