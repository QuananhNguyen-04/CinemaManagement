const FilmModel = require("../models/films.model")

class FilmController {
    static async getAvailableRoom(req, res) {
        console.log('getAvailableRoom');
        console.log(req.body);
        const { movieId, screeningDate, startTime } = req.body;

        if (!movieId || !screeningDate || !startTime) {
            return res.status(400).json({ message: 'All fields are required' });
        }
        try {
            const result = await FilmModel.getAvailableRoom(movieId, screeningDate, startTime);
            res.json(result);
        } catch (error) {
            console.error("Error adding screen", error);
            res.status(500).json({ message: 'Failed to add screening' });
        }
    }

    static async updateScreen(req, res) {
        console.log('updateScreen');
        console.log(req.body);
        const {movieId, screeningDate, startTime, roomid } = req.body;
        
        if (!movieId || !screeningDate || !startTime || !roomid) {
            return res.status(400).json({ message: 'All fields are required' });
        }
        starttime = this.toString(date) + ' ' + this.toString(starttime);
        endtime = this.toString(date) + this.toString(endtime);
        const starttime = new Date(`${screeningDate}T${startTime}`).toISOString();
        const endtime = new Date(`${screeningDate}T${endTime}`).toISOString();
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