const express = require('express');
const path = require('path');
const MovieController = require('./controllers/movies.controller');

const app = express();
const port = 3000;

// Middleware to parse JSON
app.use(express.static('public'));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/movies', MovieController.fetchMovies);
app.get('/showtimes/:movieId', MovieController.fetchShowtimes);


// // Endpoint to get data (example: fetch all movies)
// app.get('/movies', async (req, res) => {
//     try {
//         const result = await pool.query('SELECT * FROM Movie;');
//         res.json(result.rows);
//     } catch (error) {
//         console.error(error);
//         res.status(500).send('Error fetching movies');
//     }
// });

// app.get()
// // Endpoint to add data (example: add a new customer)
// app.post('/customers', async (req, res) => {
//     const { firstName, lastName, email, phoneNumber } = req.body;
//     try {
//         const query = `
//             INSERT INTO Customer (FirstName, LastName, Email, PhoneNumber) 
//             VALUES ($1, $2, $3, $4) RETURNING *;
//         `;
//         const values = [firstName, lastName, email, phoneNumber];
//         const result = await pool.query(query, values);
//         res.json(result.rows[0]);
//     } catch (error) {
//         console.error(error);
//         res.status(500).send('Error adding customer');
//     }
// });

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
