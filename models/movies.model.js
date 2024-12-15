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
            const currentTimestamp = new Date().toISOString();
            const result = await queryDatabase('SELECT * FROM Movie');
            return result.rows;
        } catch (error) {
            console.error(error);
            throw new Error('Failed to fetch movies');
        }
    }

    // Fetch showtimes for a movie
    static async getShowtimesByMovieId(movieId) {
        try {
            const result = await queryDatabase(`SELECT * FROM Screening WHERE MovieID = $1;`, [movieId]);
            return result.rows;
        } catch (error) {
            console.error(error);
            throw new Error('Failed to fetch showtimes');
        }
    }

    static async getSeatsByRoomId(roomId) {
        try {
            const result = await queryDatabase(`
                SELECT seatid as id, rownumber as row, seatnumber as column, seatstatus as status
                FROM Seats
                WHERE roomid = $1
                ORDER BY rownumber, seatnumber;
            `, [roomId]);
            
            return result.rows;
        }
        catch (error) {
            console.error(error);
            throw new Error('Failed to fetch seats');
        }
    }

    static async getMovieById(movieId) {
        const [rows] = await db.execute('SELECT * FROM movies WHERE movieid = $1', [movieId]);
        return rows[0];
    }
}

module.exports = MovieModel;
