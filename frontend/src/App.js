import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";


import Login from "./pages/Login";
import SignUp from "./pages/SignUp";

// Admin
import AdminDashboard from "./pages/admin/AdminDashboard";
import RegisterStudent from "./pages/admin/RegisterStudent";
import RemoveStudent from "./pages/admin/RemoveStudent";
import AddClass from "./pages/admin/AddClass";
import ClassSettings from "./pages/admin/ClassSettings";

// Teacher
import TeacherDashboard from "./pages/teacher/TeacherDashboard";
import TeacherClassRecords from "./pages/teacher/TeacherClassRecords";
import MarkAttendance from "./pages/teacher/MarkAttendance";
import TeacherLeaveRequests from "./pages/teacher/TeacherLeaveRequests";

// Student
import StudentDashboard from "./pages/student/StudentDashboard";
import AttendanceRecords from "./pages/student/AttendanceRecords";
import LeaveRequest from "./pages/student/LeaveRequest";
import Privacy from "./pages/student/Privacy";

const App = () => {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/signup" element={<SignUp />} />

        <Route path="/admin-dashboard" 
        element={<AdminDashboard />}/>

        <Route path="/admin/register-student"
          element={<RegisterStudent />}/>

        <Route path="/admin/remove-student"
          element={<RemoveStudent />}/>

        <Route path="/admin/add-class"
          element={<AddClass />}/>

        <Route path="/admin/class-settings/:classId"
          element={<ClassSettings />}/>

        <Route path="/teacher-dashboard"
          element={<TeacherDashboard />}/>

        <Route path="/teacher/mark-attendance"
          element={<MarkAttendance />}/>

        <Route path="/teacher/leave-requests"
          element={<TeacherLeaveRequests />}/>

        <Route path="/teacher/classes/:classId/records" 
        element={<TeacherClassRecords />} />

        <Route path="/student-dashboard"
          element={<StudentDashboard />}/>

        <Route path="/student/attendance-records/:classId"
          element={<AttendanceRecords />}/>

        <Route path="/student/leave-request"
          element={<LeaveRequest />}/>

        <Route path="/student/privacy"
          element={<Privacy />}/>

      </Routes>
    </Router>
  );
};

export default App;

