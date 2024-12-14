const express = require('express');
const path = require('path');
const FilmController = require('./controllers/films.controller');
const MovieController = require('./controllers/movies.controller');
const app = express();
const port = 3001;

// Middleware to parse JSON
app.use(express.static(path.join(__dirname, 'public/admin')));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public/admin', 'index.html'));
});

app.get('/api/movies', MovieController.fetchMovies);
app.get('/screening/:movieId', async (req, res)=> {
    res.sendFile(path.join(__dirname, 'public/admin', 'screening.html'));
});

app.get('/screening/api/showtimes/:movieId', MovieController.fetchShowtimes) 

app.post('/screening/api/getRoom', FilmController.getAvailableRoom);
app.post('/screening/api/screening/add-screening', FilmController.updateScreen);

app.get('/seats/:roomId', async (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'seats.html'));
})

app.get('/seats/api/seats/:roomId', MovieController.fetchSeats);
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
