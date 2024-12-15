const express = require('express');
const path = require('path');
const FilmController = require('./controllers/films.controller');
const MovieController = require('./controllers/movies.controller');
const CinemaController = require('./controllers/cinema.controller');
const RevenueController = require('./controllers/revenue.controller');
const app = express();
const port = 3001;

// Middleware to parse JSON
app.use(express.static(path.join(__dirname, 'public/admin')));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public/admin', 'index.html'));
});

app.get('/api/movies', MovieController.fetchMovies);
app.get('/screening/:movieId', async (req, res)=> {
    res.sendFile(path.join(__dirname, 'public/admin', 'screening.html'));
});

app.get('/screening/api/showtimes/:movieId', MovieController.fetchShowtimes) 

app.post('/screening/:movieId/api/getRoom', FilmController.getAvailableRoom);
app.post('/screening/:movieId/api/add-screening', FilmController.updateScreen);

app.get('/room', async (req, res) => {
    res.sendFile(path.join(__dirname, 'public/admin', 'room.html'));
});

app.get('/revenue', async (req, res) => {
    res.sendFile(path.join(__dirname, 'public/admin', 'revenue.html'));
});

// Route for room management
app.get('/room/api/rooms/:roomId/seats', CinemaController.viewSeats);

app.post('/room/api/:roomId/add-seat', CinemaController.addSeat);

app.get('/room/api/cinemas', CinemaController.getCinema);

app.get('/room/api/cinemas/:cinemaId', CinemaController.getRoombyCinemaId);


app.get('/revenue/api/revenue/food', RevenueController.getFoodRevenue);
app.get('/revenue/api/revenue/ticket', RevenueController.getTicketRevenue);
app.get('/revenue/api/revenue/total', RevenueController.getTotalRevenue);

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
