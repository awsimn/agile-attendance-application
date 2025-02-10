const mysql = require('mysql2');
const cors = require('cors');
const express = require('express');

require('dotenv').config();

const app = express();

app.use(cors());
app.use(express.json()); 

const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
});

db.connect((err) => {
    if (err) {
        console.error('Not connected to the database', err);
    } else {
        console.log('Connected to the database');
    }
});

// example API route to fetch data from the database
app.get('/get-attendance', (req, res) => {
    db.query('SELECT * FROM example_table', (err, results) => {
        if (err) {
            return res.status(500).send('Error');
        }
        res.json(results); 
    });
});

app.listen(5000, () => {console.log(`Server is running on port 5000`);});
