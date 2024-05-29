const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2');

const app = express();
const port = 3000;

app.use(bodyParser.json());

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'Aamish1012',
  database: 'water_intake',
});


const createTables = () => {
  pool.query(`
    CREATE TABLE IF NOT EXISTS intake (
      id INT AUTO_INCREMENT PRIMARY KEY,
      amount INT NOT NULL,
      time TIMESTAMP NOT NULL
    )
  `);

  pool.query(`
    CREATE TABLE IF NOT EXISTS goal (
      id INT AUTO_INCREMENT PRIMARY KEY,
      goal INT NOT NULL
    )
  `);
};

createTables();


app.get('/intake', (req, res) => {
  pool.query('SELECT * FROM intake', (error, results) => {
    if (error) {
      return res.status(500).send(error.message);
    }
    res.json(results);
  });
});


app.post('/intake', (req, res) => {
  const { amount, time } = req.body;
  if (!amount || !time) {
    return res.status(400).send('Amount and time are required.');
  }

  pool.query('INSERT INTO intake (amount, time) VALUES (?, ?)', [amount, time], (error) => {
    if (error) {
      return res.status(500).send(error.message);
    }
    res.status(201).send('Water intake entry logged.');
  });
});

app.get('/history', (req, res) => {
  pool.query('SELECT * FROM intake', (error, results) => {
    if (error) {
      return res.status(500).send(error.message);
    }
    res.json(results);
  });
});

app.get('/goal', (req, res) => {
  pool.query('SELECT goal FROM goal ORDER BY id DESC LIMIT 1', (error, results) => {
    if (error) {
      return res.status(500).send(error.message);
    }
    res.json(results[0] || { goal: null });
  });
});

app.post('/goal', (req, res) => {
  const { goal } = req.body;
  if (!goal || typeof goal !== 'number') {
    return res.status(400).send('Valid goal is required.');
  }

  pool.query('INSERT INTO goal (goal) VALUES (?)', [goal], (error) => {
    if (error) {
      return res.status(500).send(error.message);
    }
    res.status(201).send('Daily water intake goal updated.');
  });
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});