-- ============================================
-- HEALTH RECORD SYSTEM - Database Schema
-- Topic: Hospital Health Record Management
-- ============================================

CREATE DATABASE IF NOT EXISTS health_record_db;
USE health_record_db;

-- Reset for clean reruns
DROP TABLE IF EXISTS Prescription;
DROP TABLE IF EXISTS Medical_Record;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Medicine;
DROP TABLE IF EXISTS Diagnosis;
DROP TABLE IF EXISTS Specialization;
DROP TABLE IF EXISTS Patient;

-- TABLE 1: Patient
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    contact VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT,
    blood_group VARCHAR(5),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- TABLE 2: Specialization
CREATE TABLE Specialization (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    specialization_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
) ENGINE=InnoDB;

-- TABLE 3: Doctor
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization_id INT NOT NULL,
    license_number VARCHAR(50) UNIQUE NOT NULL,
    contact VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE,
    years_experience INT,
    FOREIGN KEY (specialization_id) REFERENCES Specialization(specialization_id)
) ENGINE=InnoDB;

-- TABLE 4: Appointment
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    notes TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- TABLE 5: Diagnosis
CREATE TABLE Diagnosis (
    diagnosis_id INT AUTO_INCREMENT PRIMARY KEY,
    diagnosis_code VARCHAR(10) UNIQUE NOT NULL,
    diagnosis_name VARCHAR(200) NOT NULL,
    description TEXT,
    severity ENUM('Mild', 'Moderate', 'Severe') DEFAULT 'Moderate',
    UNIQUE KEY unique_diagnosis_name (diagnosis_name)
) ENGINE=InnoDB;

-- TABLE 6: Medical_Record
CREATE TABLE Medical_Record (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    diagnosis_id INT NOT NULL,
    treatment_notes TEXT,
    observations TEXT,
    follow_up_required BOOLEAN DEFAULT FALSE,
    record_date DATE NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id) ON DELETE CASCADE,
    FOREIGN KEY (diagnosis_id) REFERENCES Diagnosis(diagnosis_id)
) ENGINE=InnoDB;

-- TABLE 7: Medicine
CREATE TABLE Medicine (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_name VARCHAR(100) UNIQUE NOT NULL,
    generic_name VARCHAR(100),
    manufacturer VARCHAR(100),
    price_per_unit DECIMAL(10,2),
    stock_quantity INT DEFAULT 0
) ENGINE=InnoDB;

-- TABLE 8: Prescription
CREATE TABLE Prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    record_id INT NOT NULL,
    medicine_id INT NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    frequency VARCHAR(50) NOT NULL,
    duration_days INT NOT NULL,
    quantity INT NOT NULL,
    prescription_date DATE NOT NULL,
    FOREIGN KEY (record_id) REFERENCES Medical_Record(record_id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
) ENGINE=InnoDB;

-- SAMPLE DATA
INSERT INTO Specialization (specialization_name, description) VALUES
('Cardiology', 'Heart and cardiovascular diseases'),
('Neurology', 'Nervous system disorders'),
('Dermatology', 'Skin diseases and conditions'),
('Orthopedics', 'Bone and joint disorders'),
('General Medicine', 'General health and wellness');

INSERT INTO Doctor (name, specialization_id, license_number, contact, email, years_experience) VALUES
('Dr. Rajesh Kumar', 1, 'LIC001', '9876543210', 'rajesh.kumar@hospital.com', 12),
('Dr. Priya Singh', 2, 'LIC002', '9876543211', 'priya.singh@hospital.com', 10),
('Dr. Amit Patel', 3, 'LIC003', '9876543212', 'amit.patel@hospital.com', 8),
('Dr. Neha Gupta', 4, 'LIC004', '9876543213', 'neha.gupta@hospital.com', 14);

INSERT INTO Patient (name, dob, gender, contact, email, address, blood_group) VALUES
('John Doe', '1990-05-15', 'Male', '9123456789', 'john.doe@email.com', '123 Main St, City', 'O+'),
('Jane Smith', '1985-03-22', 'Female', '9123456790', 'jane.smith@email.com', '456 Oak Ave, City', 'AB+'),
('Robert Johnson', '1992-07-10', 'Male', '9123456791', 'robert.j@email.com', '789 Pine Rd, City', 'B+'),
('Sarah Williams', '1988-11-30', 'Female', '9123456792', 'sarah.w@email.com', '321 Elm St, City', 'A-');

INSERT INTO Diagnosis (diagnosis_code, diagnosis_name, description, severity) VALUES
('D001', 'Hypertension', 'High blood pressure condition', 'Moderate'),
('D002', 'Migraine', 'Severe headache disorder', 'Severe'),
('D003', 'Dermatitis', 'Skin inflammation', 'Mild'),
('D004', 'Arthritis', 'Joint inflammation and pain', 'Moderate');

INSERT INTO Medicine (medicine_name, generic_name, manufacturer, price_per_unit, stock_quantity) VALUES
('Aspirin 500mg', 'Acetylsalicylic Acid', 'Pharma Co', 5.50, 100),
('Amoxicillin 250mg', 'Amoxicillin', 'Health Labs', 2.25, 150),
('Ibuprofen 400mg', 'Ibuprofen', 'Care Pharma', 3.75, 200),
('Paracetamol 500mg', 'Acetaminophen', 'Med Corp', 1.99, 300);

INSERT INTO Appointment (patient_id, doctor_id, appointment_date, appointment_time, status, notes) VALUES
(1, 1, '2026-04-05', '10:00:00', 'Scheduled', 'Routine checkup'),
(2, 2, '2026-04-06', '14:30:00', 'Scheduled', 'Headache consultation'),
(3, 3, '2026-04-07', '11:00:00', 'Completed', 'Skin condition review'),
(4, 4, '2026-04-08', '15:00:00', 'Scheduled', 'Joint pain assessment');

INSERT INTO Medical_Record (appointment_id, diagnosis_id, treatment_notes, observations, follow_up_required, record_date) VALUES
(1, 1, 'Start blood pressure medication', 'BP elevated at 140/90', TRUE, '2026-04-05'),
(2, 2, 'Prescribed migraine relief', 'Patient reports stress-induced headaches', TRUE, '2026-04-06'),
(3, 3, 'Topical cream prescribed', 'Mild skin irritation observed', FALSE, '2026-04-07'),
(4, 4, 'Physical therapy recommended', 'Knee pain due to old injury', TRUE, '2026-04-08');

INSERT INTO Prescription (record_id, medicine_id, dosage, frequency, duration_days, quantity, prescription_date) VALUES
(1, 1, '500mg', 'Once daily', 30, 30, '2026-04-05'),
(2, 4, '500mg', 'Twice daily', 7, 14, '2026-04-06'),
(3, 2, 'Apply twice', 'Morning and evening', 14, 1, '2026-04-07'),
(4, 3, '400mg', 'Thrice daily with food', 10, 30, '2026-04-08');

CREATE INDEX idx_patient_contact ON Patient(contact);
CREATE INDEX idx_doctor_specialization ON Doctor(specialization_id);
CREATE INDEX idx_appointment_patient ON Appointment(patient_id);
CREATE INDEX idx_appointment_date ON Appointment(appointment_date);
CREATE INDEX idx_medical_record_appointment ON Medical_Record(appointment_id);
CREATE INDEX idx_prescription_record ON Prescription(record_id);
