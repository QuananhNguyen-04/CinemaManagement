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
    static async addScreening(roomId, movieId, starttime, screeningDate) {
        try {
            const result = await queryDatabase(`INSERT INTO screenings ($1, $2, $3, $4, $5)
        RETURNING *'
        `, [roomId, movieId, starttime, endtime, 100]);
        }
        catch (error) {
            throw new Error('Failed to add screening')
        }
    }

    static async viewTotalRevenue(cinemaid, date) {
        try {
            const result = await queryDatabase(`SELECT * FROM get_total_revenue($1, $2)`
                , [cinemaid, date]
            );
            return result.rows;
        }
        catch (error) {
            throw new Error('Failed to view total revenue');
        }
    }

    static async viewTotalRevenuefromTicket(cinemaid, date) {
        try {
            const result = await queryDatabase(`SELECT * FROM get_ticket_revenue($1, $2)`
                , [cinemaid, date]);
            return result.rows;
        }
        catch (error) {
            throw new Error('Failed to view ticket revenue');
        }
    }   

    static async viewTotalRevenuefromFood(cinemaid, date) {
        try {
            const result = await queryDatabase(`SELECT * FROM get_food_revenue($1, $2)`
                , [cinemaid, date]);
            return result.rows;
        }
        catch (error) {
            throw new Error('Failed to view food revenue');
        }
    }

    static async getAvailableRoom(movieid, date, starttime) {
        try {
            console.log(movieid, date, starttime);
            const result = await queryDatabase(`SELECT * FROM validate_rooms($1, $2, $3) `,
                [movieid, date, starttime]
            );

            return result.rows;
        }
        catch (error) {
            throw new Error('Failed to get available room');
        }
    }
}

module.exports = FilmModel