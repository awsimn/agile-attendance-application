import React from 'react';

function Attendance({ students }) {
  return (
    <div>
      <h2>Attendance</h2>
      <ol>
        {students.map((student) => (
          <li>
            {student.name} is {student.status ? ' ' : 'Not'} Present
          </li>
        ))}
      </ol>
    </div>
  );
}

export default Attendance;
