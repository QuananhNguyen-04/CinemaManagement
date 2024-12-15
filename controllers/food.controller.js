const FoodModel = require('../models/food.model');

class FoodController {
    static fetchFood(req, res) {
        const foodItems = FoodModel.getAllFoodItems();
        res.json(foodItems);
    }
}

module.exports = FoodController;
