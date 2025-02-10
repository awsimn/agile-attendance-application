// src/App.js
import './App.css';
import React, { useEffect, useState } from 'react';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
import axios from 'axios';

import Home from './webpages/Home';
import Attendance from './webpages/Attendance';

function App() {
  const [attendanceData, setAttendanceData] = useState([]);

  useEffect(() => {
    axios.get('http://localhost:5000/get-attendance')
      .then((response) => {
        setAttendanceData(response.data); 
      })
      .catch((error) => {
        console.error('There was an error fetching the data:', error);
      });
  }, []); 

  return (
    <Router>
      <div className="App">
        <header className="App-header">
          <h1>React App</h1>
          <li><Link to="/">Home</Link></li>
          <li><Link to="/attendance">Attendance</Link></li>

          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/attendance" element={<Attendance students={attendanceData} />} />
          </Routes>
        </header>
      </div>
    </Router>
  );
}

export default App;
