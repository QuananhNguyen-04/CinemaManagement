const db = require('../config/db');  // Assuming you have a db.js file that manages the database connection

class revenueModel {
// Get food revenue for a specific cinema and date
    static async getFoodRevenue(cinemaId, date){
        try {
            const result = await db.query(
                'SELECT get_food_revenue($1, $2) AS food_revenue',
                [cinemaId, date]
            );
            return result.rows[0]?.food_revenue || 0;
        } catch (error) {
            throw new Error('Error fetching food revenue: ' + error.message);
        }
    };

    // Get ticket revenue for a specific cinema and date
    static async getTicketRevenue(cinemaId, date) {
        try {
            const result = await db.query(
                'SELECT get_ticket_revenue($1, $2) AS ticket_revenue',
                [cinemaId, date]
            );
            return result.rows[0]?.ticket_revenue || 0;
        } catch (error) {
            throw new Error('Error fetching ticket revenue: ' + error.message);
        }
    };

    // Get total revenue for a specific cinema and date (from all sources)
    static async getTotalRevenue(cinemaId, date){
        try {
            const result = await db.query(
                'SELECT get_total_revenue($1, $2) AS total_revenue',
                [cinemaId, date]
            );
            return result.rows[0]?.total_revenue || 0;
        } catch (error) {
            throw new Error('Error fetching total revenue: ' + error.message);
        }
    };
}

module.exports = revenueModel;
