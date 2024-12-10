const MovieModel = require('../models/movies.model');

class MovieController {
    // Get all movies and return JSON response
    static async fetchMovies(req, res) {
        try {
            const movies = await MovieModel.getAllMovies();
            console.log(movies);
            res.json(movies);
        } catch (error) {
            console.error(error);
            res.status(500).json({ error: 'Failed to fetch movies' });
        }
    }

    // Get showtimes for a specific movie
    static async fetchShowtimes(req, res) {
        try {
            const { movieId } = req.params;
            const showtimes = await MovieModel.getShowtimesByMovieId(movieId);
            res.json(showtimes);
        } catch (error) {
            console.error(error);
            res.status(500).json({ error: 'Failed to fetch showtimes' });
        }
    }
}

module.exports = MovieController;
