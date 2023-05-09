const express = require("express")
const Plan = require("../models/plan");
const planRouter = express.Router();



planRouter.post('/plans', async (req, res) => {
    try {
        const { price, duration } = req.body;

        const plan = new Plan({
            price,
            duration,
        });

        await plan.save();

        res.status(200).json({ msg: 'Plan created successfully' });
    } catch (err) {
        console.error("Error creating plan:", err);
        res.status(500).json({ msg: "Server error" });
    }
});



planRouter.get('/plans', async (req, res) => {
    const plans = await Plan.find();
    res.status(200).json(plans);
});

planRouter.delete('/plans/:id', async (req, res) => {
    try {
        const plan = await Plan.findByIdAndDelete(req.params.id);
        if (!plan) {
            return res.status(404).json({ msg: 'Plan not found' });
        }
        res.json({ msg: 'Plan deleted successfully' });
    } catch (error) {
        console.error('Error deleting plan:', error);
        res.status(500).json({ msg: 'Server error' });
    }
});

module.exports = planRouter