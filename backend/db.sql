CREATE DATABASE IF NOT EXISTS db_attendance_system;
USE db_attendance_system;

-- Database tables

-- User Data
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,          -- Identifier for all users
    email VARCHAR(255) UNIQUE NOT NULL,         -- Unique login credentials
    user_password VARCHAR(255) NOT NULL,        -- Password
    role ENUM('admin', 'teacher', 'student') NOT NULL, -- RBAC (Role-Based Access Control)
    full_name VARCHAR(255) NOT NULL,            -- Human-readable name
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Account creation timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Last update tracker
);

-- Students Specific Data
CREATE TABLE students (
    user_id INT PRIMARY KEY,                    -- 1:1 relationship with users table
    consent_given BOOLEAN DEFAULT FALSE,        -- General data consent
    facial_data_consent_given BOOLEAN DEFAULT FALSE, -- Facial recognition consent
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Classes Specific Data
CREATE TABLE classes (
    id INT PRIMARY KEY AUTO_INCREMENT,          -- Class identifier
    class_name VARCHAR(255) NOT NULL,           -- Course name (e.g "Comp Security")
    teacher_id INT NOT NULL,                    -- Teacher reference
    schedule JSON,                              -- Flexible timetable storage
    FOREIGN KEY (teacher_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Class Enrollment Data
CREATE TABLE class_enrollment (
    class_id INT NOT NULL,                      -- Reference to class
    student_id INT NOT NULL,                    -- Reference to student
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Enrollment timestamp
    PRIMARY KEY (class_id, student_id),         -- PK
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
    reason TEXT,                                -- Text explanation
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    responded_by INT,                           -- Approving/rejecting teacher
    response_notes TEXT,                        -- Teacher comments
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE
);

-- Attendance Record Data
CREATE TABLE attendance (
    id INT PRIMARY KEY AUTO_INCREMENT,          -- Attendance record
    student_id INT NOT NULL,                    -- Student being tracked
    class_id INT NOT NULL,                      -- Associated class
    attendance_date DATE NOT NULL,              -- Date of attendance
    status ENUM('present', 'absent', 'tardy') NOT NULL, -- Attendance state
    method ENUM('facial', 'manual') NOT NULL,   -- Tracking method
    marked_by INT,                              -- Teacher ID or system marker
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE
);