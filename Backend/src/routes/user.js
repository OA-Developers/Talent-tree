const express = require("express");
const User = require("../models/user");
const jwt = require("jsonwebtoken");
const userRouter = express.Router();

// Check if user is subscribed and has access to feature
userRouter.get("/checkSubscribed", async (req, res) => {
    try {
        const token = req.headers.authorization.split(" ")[1];
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const userId = decoded.userId;
        const user = await User.findById(userId);
        if (user.subscription === null) {
            res.status(403).json({ message: "User is not subscribed" });
        } else {
            const currentDate = new Date();
            const endDate = new Date(user.subscription.endDate);
            if (currentDate > endDate) {
                await User.findByIdAndUpdate(userId, { subscription: null });
                res.status(403).json({ message: "User's subscription has expired" });
            } else {
                res.status(200).json({ message: "User is subscribed and has access to feature" });
            }
        }
    } catch (error) {
        res.status(500).json({ message: "Internal server error" });
    }
});

module.exports = userRouter;
