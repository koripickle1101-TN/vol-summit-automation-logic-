-- VOL SUMMIT RCM BASE CAMP™ INTAKE SCHEMA
-- VERSION: 2026.1.0
-- FOCUS: FRONT-END REVENUE INTEGRITY

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    ZipCode VARCHAR(10),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE InsuranceProviders (
    ProviderID INT PRIMARY KEY AUTO_INCREMENT,
    ProviderName VARCHAR(100) NOT NULL,
    PayerType VARCHAR(50), -- Private, Medicare, Medicaid
    ClaimsAddress VARCHAR(255)
);

CREATE TABLE EligibilityAudits (
    AuditID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    ProviderID INT,
    VerificationStatus VARCHAR(20), -- Verified, Pending, Denied
    VerificationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CoPayAmount DECIMAL(10,2),
    DeductibleRemaining DECIMAL(10,2),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (ProviderID) REFERENCES InsuranceProviders(ProviderID)
);

-- REVENUE CYCLE INTEGRITY VIEW
CREATE VIEW Intake_Leakage_Report AS
SELECT 
    p.LastName, 
    p.FirstName, 
    i.ProviderName, 
    e.VerificationStatus, 
    e.VerificationDate
FROM Patients p
JOIN EligibilityAudits e ON p.PatientID = e.PatientID
JOIN InsuranceProviders i ON e.ProviderID = i.ProviderID
WHERE e.VerificationStatus != 'Verified';
