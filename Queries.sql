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

SELECT DAYNAME(appointment.booked_at)
FROM appointment
WHERE appointment.booked_at > (CURRENT_DATE() - INTERVAL 6 MONTH)
GROUP BY DAYNAME(appointment.booked_at)
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT medication.name
FROM diagnosis
JOIN appointment_diagnosis ON appointment_diagnosis.diagnosis_code = diagnosis.diagnosis_code
JOIN doctor_appointment ON doctor_appointment.doctor_appointment_id = appointment_diagnosis.doctor_appointment_id
JOIN prescription ON prescription.doctor_appointment_id = doctor_appointment.doctor_appointment_id
JOIN medication ON medication.medication_id = prescription.medication_id
WHERE diagnosis.diagnosis_name = "Type 2 Diabetes"
GROUP BY medication.name
ORDER BY COUNT(prescription.medication_id) DESC
LIMIT 5;

SELECT appointment.appointment_id, billing_patient.amount_paid
FROM billing_patient
JOIN billing ON billing.billing_id = billing_patient.billing_id
JOIN appointment ON appointment.appointment_id = billing.appointment_id
WHERE billing_patient.amount_paid = (
    SELECT MAX(billing_patient.amount_paid)
    FROM billing_patient
);

