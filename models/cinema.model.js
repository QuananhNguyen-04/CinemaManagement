const db = require('../config/db'); // Assuming you have a db.js that handles PostgreSQL connection

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

class CinemaModel {
    // Function 1: View seats in a room
    static async viewSeatsInRoom(roomId) {
        const result = await db.query('SELECT * FROM view_seats_in_room($1)', [roomId]);
        return result.rows;
    }

    // Function 2: Add seat to room
    static async addSeatToRoom(cinemaId, roomId, row, number) {
        const result = await db.query('SELECT add_seat_to_room($1, $2, $3, $4)', [cinemaId, roomId, row, number]);
        return result;
    }

    static async removeSeatFromRoom(cinemaId, roomId, row, number) {
        const result = await db.query('SELECT delete_seat($1, $2, $3, $4)', [cinemaId, roomId, row, number])
        return result;
    }
    
    // Function 3: Delete seat from room
    static async deleteSeat(seatId) {
        const result = await db.query('SELECT delete_seat($1)', [seatId]);
        return result;
    }

    // Function 4: Get food revenue
    static async getFoodRevenue(cinemaId, date) {
        const result = await db.query('SELECT get_food_revenue($1, $2)', [cinemaId, date]);
        return result.rows[0].get_food_revenue;
    }

    // Function 5: Get ticket revenue
    static async getTicketRevenue(cinemaId, date) {
        const result = await db.query('SELECT get_ticket_revenue($1, $2)', [cinemaId, date]);
        return result.rows[0].get_ticket_revenue;
    }

    // Function 6: Get total revenue (food + ticket)
    static async getTotalRevenue(cinemaId, date) {
        const result = await db.query('SELECT get_total_revenue($1, $2)', [cinemaId, date]);
        return result.rows[0].get_total_revenue;
    }

    static async getCinema() {
        const result = await db.query('SELECT * FROM Cinema');
        console.log(result);
        return result.rows;
    }

    static async getRoom(cinemaid) {
        console.log(cinemaid)
        const result = await queryDatabase(`SELECT * FROM Room WHERE cinemaid = $1`, [cinemaid]);
        return result.rows;
    }
}

module.exports = CinemaModel;
