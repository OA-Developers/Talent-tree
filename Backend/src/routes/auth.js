const express = require("express");
const bcrypt = require("bcrypt");
const otpGenerator = require("otp-generator");
const nodemailer = require("nodemailer");
const User = require("../models/user");
const adminUser = require("../models/adminUser");
const Registration = require("../models/registration");
const axios = require("axios");
const jwt = require("jsonwebtoken");
const authRouter = express.Router();

const auth = require("../middlewares/auth");

// admin signin`

function getRandomNumber(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

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
      return res.status(400).json({ msg: "Incorrect password" });
    }
    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Sign Up
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { mobile, password } = req.body;

    // Check if mobile and password are empty
    if (!mobile || !password) {
      return res
        .status(400)
        .json({ msg: "Mobile and password are required fields." });
    }

    const name = `Talent${getRandomNumber(1, 10000)}`;

    const existingUser = await User.findOne({ mobile });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with the same mobile already exists!" });
    }

    const hashedPassword = await bcrypt.hash(password, 8);

    let user = new User({
      name,
      password: hashedPassword,
      mobile,
      profileImage: "",
    });
    user = await user.save();

    return res.json({ msg: "User created." });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

// Sign In
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { mobile, password } = req.body;

    // Check if mobile and password are empty
    if (!mobile || !password) {
      return res
        .status(400)
        .json({ msg: "Mobile and password are required fields." });
    }

    const user = await User.findOne({ mobile });
    if (!user) {
      return res.status(400).json({
        msg: "User with this mobile number does not exist!",
      });
    }

    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password" });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    return res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Sign In

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { mobile, password } = req.body;
    const user = await User.findOne({ mobile });
    if (!user) {
      return res.status(400).json({
        msg: "User with this mobile no does not exists!",
      });
    }

    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password" });
    }
    const token = jwt.sign({ id: user._id }, "passwordKey");
    return res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res.json(false);
    }
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);
    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.get("/getUser", auth, async (req, res) => {
  try {
    const user = await User.findById(req.user);

    if (!user) {
      return res.status(400).json({ msg: "User not found." });
    }

    const registration = await Registration.findOne({ userId: req.user });
    let isRegistered = !!registration; // Using !! to convert to a boolean

    let isSubscribed = false;
    if (user.subscription) {
      const currentDate = new Date();
      const endDate = new Date(user.subscription.endDate);
      isSubscribed = currentDate < endDate;
    }

    const response = {
      ...user._doc,
      token: req.token,
      isSubscribed,
      isRegistered,
    };

    res.json(response);
  } catch (error) {
    console.error("Error fetching user:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});


authRouter.post("/api/reset-password", async (req, res) => {
  try {
    const { mobile, newPassword } = req.body;
    if (!mobile || !newPassword) {
      return res.status(400).json({ msg: "Mobile and newPassword are required fields." });
    }
    const user = await User.findOne({ mobile });

    if (!user) {
      return res.status(400).json({ msg: "User with this mobile number does not exist!" });
    }

    // Hash the new password
    const hashedPassword = await bcrypt.hash(newPassword, 8);
    user.password = hashedPassword;
    await user.save();

    return res.json({ msg: "Password reset successful." });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


module.exports = authRouter;
