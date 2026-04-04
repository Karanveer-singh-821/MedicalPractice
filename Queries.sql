SELECT doctors.first_name, doctors.last_name, doctor_appointment.appointment_id, appointment.patient_id, patients.first_name, patients.last_name
FROM doctors
JOIN doctor_appointment ON doctor_appointment.doctor_id = doctors.doctor_id
JOIN appointment ON appointment.appointment_id = doctor_appointment.appointment_id
JOIN patients ON patients.patient_id = appointment.patient_id
WHERE doctors.last_name = "Langford";

SELECT patients.first_name, patients.last_name, COUNT(*) as "No. of Cancellation Penalties"
FROM appointment
JOIN patients ON patients.patient_id = appointment.patient_id
WHERE appointment.cancellation_penalty != 0 AND patients.first_name = "Chris" AND patients.last_name = 'Lee';

SELECT doctors.first_name as "Doctor First Name", doctors.last_name as "Doctor Last Name", COUNT(*) AS "Specific Medication Prescription Count"
FROM prescription
JOIN doctor_appointment ON doctor_appointment.doctor_appointment_id = prescription.doctor_appointment_id
JOIN doctors ON doctors.doctor_id = doctor_appointment.doctor_id
JOIN medication ON medication.medication_id = prescription.medication_id
WHERE medication.name = "Hydrocortisol"
GROUP BY doctor_appointment.doctor_id
ORDER BY COUNT(*) DESC;

SELECT appointment.appointment_id, billing.total_amount
FROM appointment
JOIN billing ON billing.appointment_id = appointment.appointment_id
WHERE billing.total_amount = (
    SELECT MAX(total_amount)
    FROM billing
);

SELECT appointment_type.type, AVG(appointment.duration_minutes)
FROM appointment_type
JOIN appointment ON appointment.appointment_type_id = appointment_type.appointment_type_id
GROUP BY appointment_type.type
ORDER BY AVG(appointment.duration_minutes) DESC
LIMIT 1;

