const express = require("express");
const bcrypt = require("bcrypt");
const User = require("../models/user");
const adminUser = require("../models/adminUser");
const jwt = require("jsonwebtoken");
const authRouter = express.Router();

// admin signin

authRouter.post("/admin/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await adminUser.findOne({ email });
    if (!user) {
      return res.status(400).json({
        msg: "User with this email does not exists!",
      });
    }


    if (user.password !== password) {
      console.log(user, password, user.password);
      return res.status(400).json({ msg: "Incorrect password" });
    }
    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
})










authRouter.post("/api/signup", async (req, res) => {
  try {
    const { email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }
    const hashedPassword = await bcrypt.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
    });
    user = await user.save();
    return res.json(user);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

// Sign In

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({
        msg: "User with this email does not exists!",
      });
    }

    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password" });
    }
    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
