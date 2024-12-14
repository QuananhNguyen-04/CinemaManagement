const db = require('../config/db');

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

class FilmModel {
    static async addScreening(roomId, movieId, starttime, endtime) {
        try {
            const result = await queryDatabase(`INSERT INTO screenings (movie_id, screening_date, start_time, end_time, room)
        VALUES ($1, $2, $3, $4, $5) RETURNING *'
        `);
        }
        catch (error) {
            throw new Error('Failed to add screening')
        }
    }

    static async viewTotalCustomer() {

    }
    
    static async viewTotalRevenue() {

    }

    static async viewTotalRevenuefromTicket() {

    }

    static async viewTotalRevenuefromFood() {

    }
}

module.exports = FilmModel