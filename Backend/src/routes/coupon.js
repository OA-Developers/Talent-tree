const express = require("express")
const Coupon = require("../models/coupon");
const couponRouter = express.Router();



couponRouter.post('/coupons', async (req, res) => {
    try {
        const { code, expiry, discount } = req.body;

        const coupon = new Coupon({
            code, expiry, discount
        });

        await coupon.save();

        res.status(200).json({ msg: 'Coupon created successfully' });
    } catch (err) {
        console.error("Error creating Coupon:", err);
        res.status(500).json({ msg: "Server error" });
    }
});



couponRouter.get('/coupons', async (req, res) => {
    const Coupons = await Coupon.find();
    res.status(200).json(Coupons);
});

couponRouter.delete('/coupons/:id', async (req, res) => {
    try {
        const coupon = await Coupon.findByIdAndDelete(req.params.id);
        if (!coupon) {
            return res.status(404).json({ msg: 'Coupon not found' });
        }
        res.json({ msg: 'Coupon deleted successfully' });
    } catch (error) {
        console.error('Error deleting Coupon:', error);
        res.status(500).json({ msg: 'Server error' });
    }
});

module.exports = couponRouter