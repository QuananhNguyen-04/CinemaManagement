const db = require('../config/db.js');

const queryDatabase = (query, params = []) => {
    return new Promise((resolve, reject) => {
        db.query(query, params, (err, result) => {
            if (err) {
                reject(err);
            } else {
                resolve(result);
            }
        });
    });
};

class MovieModel {
    // Fetch all movies
    static async getAllMovies() {
        try {
            const result = await queryDatabase('SELECT * FROM Movie');
            return result.rows;
        } catch (error) {
            console.error(error);
            throw new Error('Failed to fetch movies');
        }
    }

    // Fetch showtimes for a movie
    static async getShowtimesByMovieId(movieId) {
        const [rows] = await db.execute('SELECT * FROM showtimes WHERE movie_id = ?', [movieId]);
        return rows;
    }

    static async getMovieById(movieId) {
        const [rows] = await db.execute('SELECT * FROM movies WHERE movieid = ?', [movieId]);
        return rows[0];
    }
}

module.exports = MovieModel;
