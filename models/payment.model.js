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

class PaymentModel{
    static async addTicket(screeningID, price, age, online, seatID) {
        try {
            const result = await db.query('INSERT INTO Ticket(ScreeningID, Price, Age, OnOffline, SeatID) VALUES ($1, $2, $3, $4, $5)', 
                [screeningID, price, age, online, seatID]);
            return result;
        }
        catch (error) {
            console.error(error);
        }
    }
}

module.exports = PaymentModel;