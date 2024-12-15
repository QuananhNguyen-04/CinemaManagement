const revenueModel = require('../models/revenue.model');  // Importing the model

class RevenueController {
    // Get food revenue for a specific cinema and date
    static async getFoodRevenue(req, res) {
        const { cinemaId, date } = req.query;
        try {
            const foodRevenue = await revenueModel.getFoodRevenue(cinemaId, date);
            res.json(foodRevenue);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // Get ticket revenue for a specific cinema and date
    static async getTicketRevenue(req, res) {
        const { cinemaId, date } = req.query;
        try {
            const ticketRevenue = await revenueModel.getTicketRevenue(cinemaId, date);
            res.json(ticketRevenue);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    // Get total revenue for a specific cinema and date
    static async getTotalRevenue(req, res) {
        const { cinemaId, date } = req.query;
        try {
            const totalRevenue = await revenueModel.getTotalRevenue(cinemaId, date);
            res.json(totalRevenue);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}

module.exports = RevenueController;
