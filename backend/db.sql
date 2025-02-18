CREATE DATABASE IF NOT EXISTS db_attendance_system;
USE db_attendance_system;

-- Database tables

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    user_password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'teacher', 'student') NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Students Specific Data
CREATE TABLE students (
    user_id INT PRIMARY KEY,
    consent_given BOOLEAN DEFAULT FALSE,
    facial_data_consent_given BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Classes Specific Data
CREATE TABLE classes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(255) NOT NULL,
    teacher_id INT NOT NULL,
    schedule JSON,
    FOREIGN KEY (teacher_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Class Enrollment Data
CREATE TABLE class_enrollment (
    class_id INT NOT NULL,
    student_id INT NOT NULL,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (class_id, student_id),
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Leave Request Data
CREATE TABLE leave_requests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,                    -- Requester
    class_id INT NOT NULL,                      -- Affected class
    start_date DATE NOT NULL,                   -- Leave start
    end_date DATE NOT NULL,                     -- Leave end
    reason TEXT,                                -- Free-text explanation
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    responded_by INT,                           -- Approving/rejecting teacher
    response_notes TEXT,                        -- Teacher comments
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE
);