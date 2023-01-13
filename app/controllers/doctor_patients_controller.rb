class DoctorPatientsController < ApplicationController 

  def destroy 
    doctor = Doctor.find(params[:doctor_id])
    patient = Patient.find(params[:id])
    doctorpatient = DoctorPatient.find_by(doctor: doctor, patient: patient)
    doctorpatient.destroy 
    redirect_to doctor_path(doctor)
  end
end