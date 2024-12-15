const CinemaModel = require('../models/cinema.model');

class CinemaController {

    static async getCinema(req, res) {
        try {
            const cinema = await CinemaModel.getCinema();
            res.json(cinema);
        }
        catch (error){
            console.error(error);
            res.status(500).send("Error fetching cinema");
        }
    }   
    // Controller to view seats in a room
    static async viewSeats(req, res) {
        try {
            const roomId = req.params.roomId;
            const seats = await CinemaModel.viewSeatsInRoom(roomId);
            res.json(seats);
        } catch (error) {
            console.error(error);
            res.status(500).send("Error fetching seats");
        }
    }

    // Controller to add a seat to a room
    static async addSeat(req, res) {
        try {
            const { cinemaId, row, number } = req.body;
            const {roomId }= req.params;
            console.log( cinemaId, roomId, row, number )
            const result = await CinemaModel.addSeatToRoom(cinemaId, roomId, row, number);
            res.json({ message: "Seat added successfully" });
        } catch (error) {
            console.error(error);
            res.status(500).send("Error adding seat");
        }
    }

    static async removeSeat(req, res) {
        try {
            const { cinemaId, row, number } = req.body;
            const {roomId }= req.params;
            console.log( cinemaId, roomId, row, number )
            const result = await CinemaModel.removeSeatFromRoom(cinemaId, roomId, row, number);
            res.json({ message: "Seat remove successfully" });
        } catch (error) {
            console.error(error);
            res.status(500).send("Error removing seat");
        }
    }
    // Controller to delete a seat from a room
    static async deleteSeat(req, res) {
        try {
            const { seatId } = req.body;
            await CinemaModel.deleteSeat(seatId);
            res.json({ message: "Seat deleted successfully" });
        } catch (error) {
            console.error(error);
            res.status(500).send("Error deleting seat");
        }
    }

    // Controller to get food revenue
    static async getFoodRevenue(req, res) {
        try {
            const { cinemaId, date } = req.query;
            const revenue = await CinemaModel.getFoodRevenue(cinemaId, date);
            res.json({ revenue });
        } catch (error) {
            console.error(error);
            res.status(500).send("Error fetching food revenue");
        }
    }

    // Controller to get ticket revenue
    static async getTicketRevenue(req, res) {
        try {
            const { cinemaId, date } = req.query;
            const revenue = await CinemaModel.getTicketRevenue(cinemaId, date);
            res.json({ revenue });
        } catch (error) {
            console.error(error);
            res.status(500).send("Error fetching ticket revenue");
        }
    }

    // Controller to get total revenue (food + ticket)
    static async getTotalRevenue(req, res) {
        try {
            const { cinemaId, date } = req.query;
            const revenue = await CinemaModel.getTotalRevenue(cinemaId, date);
            res.json({ revenue });
        } catch (error) {
            console.error(error);
            res.status(500).send("Error fetching total revenue");
        }
    }

    // Controller to cleanup tickets and update seat status
    static async cleanupTickets(req, res) {
        try {
            await CinemaModel.cleanupTicketsAndUpdateSeats();
            res.json({ message: "Tickets cleaned and seats updated successfully" });
        } catch (error) {
            console.error(error);
            res.status(500).send("Error cleaning tickets and updating seats");
        }
    }

    static async getRoombyCinemaId(req, res) {
        try {
            const {cinemaId} = req.params;
            // console.log(req);
            const rooms = await CinemaModel.getRoom(cinemaId);
            console.log("rooms:", rooms);
            res.json(rooms);
        }
        catch {
            console.error(error);
            res.status(500).send("Error fetching room");
        }
    }
}

module.exports = CinemaController;
