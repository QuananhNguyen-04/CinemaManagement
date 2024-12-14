const FilmModel = require("../models/films.model")

class FilmController {
    static async getAvailableRoom(req, res) {
        const { movieId, screeningDate, startTime } = req.body;
        
    }

    static async updateScreen(req, res) {
        const {movieId, screeningDate, startTime, roomid } = req.body;
        
        if (!movieId || !screeningDate || !startTime || !endTime || !room) {
            return res.status(400).json({ message: 'All fields are required' });
        }
        starttime = this.toString(date) + this.toString(starttime);
        endtime = this.toString(date) + this.toString(endtime);
        try {
            await FilmModel.addScreening(roomid, movieId, starttime, endtime);
            res.json(201).json({message: 'Added successfully'});
        } catch (error) {
            console.error("Error adding screen", error);
            res.status(500).json({ message: 'Failed to add screening' });
        }
    }
}

module.exports = FilmController;