const PaymentModel = require('../models/payment.model');

class PaymentController {
    static async addTicket(req, res) {
        try {
            const { screeningID, price, movieID, online, seatID } = req.body;
            console.log(screeningID, price, movieID, online, seatID);
            await PaymentModel.addTicket(screeningID, price, movieID, online, seatID);
        }
        catch (error) {
            console.error(error);
            res.status(500).send("Error adding ticket");
        }
    }
}

module.exports = PaymentController;
