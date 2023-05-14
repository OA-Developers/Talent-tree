const express = require("express");
const bcrypt = require("bcrypt");
const User = require("../models/user");
const adminUser = require("../models/adminUser");
const Registration = require("../models/registration");
const jwt = require("jsonwebtoken");
const authRouter = express.Router();

const auth = require("../middlewares/auth")

// admin signin

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
})

authRouter.post("/admin/signup", async (req, res) => {
  try {
    const { email, password } = req.body;

    const existingUser = await adminUser.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    let user = new adminUser({
      email,
      password,
    });
    user = await user.save();
    return res.json(user);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});


// user routes

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { email, password } = req.body;
    const name = `Talent${getRandomNumber(1, 10000)}`

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }
    const hashedPassword = await bcrypt.hash(password, 8);

    let user = new User({
      name,
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
    const verified = jwt.verify(token, "passwordKey")
    if (!verified)
      return res.json(false);
    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true)
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
})

authRouter.get("/getUser", auth, async (req, res) => {
  const user = await User.findById(req.user);
  const registration = await Registration.findOne({ userId: req.user });
  var isRegistered;



  if (registration) {
    isRegistered = true;
  } else {
    isRegistered = false
  }
  const isSubscribed = user.subscription !== null;
  const response = {
    ...user._doc,
    token: req.token,
    isSubscribed,
    isRegistered: isRegistered,
  };

  res.json(response);
});




// Usage example:// prints a random number between 1 and 100


module.exports = authRouter;
