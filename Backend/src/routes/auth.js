const express = require("express");
const bcrypt = require("bcrypt");
const otpGenerator = require("otp-generator");
const nodemailer = require("nodemailer");
const User = require("../models/user");
const adminUser = require("../models/adminUser");
const Registration = require("../models/registration");
const jwt = require("jsonwebtoken");
const authRouter = express.Router();

const auth = require("../middlewares/auth")

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
})

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { email, password } = req.body;
    const name = `Talent${getRandomNumber(1, 10000)}`;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ msg: "User with the same email already exists!" });
    }

    const otp = otpGenerator.generate(6, { alphabets: false, upperCase: false, specialChars: false });
    const otpExpiry = Date.now() + 600000; // OTP expiry set to 10 minutes from now

    const hashedPassword = await bcrypt.hash(password, 8);

    let user = new User({
      name,
      email,
      password: hashedPassword,
      otp,
      otpExpiry,
      profileImage: ""
    });
    user = await user.save();

    // Send OTP to the user's email
    const transporter = nodemailer.createTransport({
      host: "mail.talenttree.in",
      port: 465,
      secure: true, // true for 465, false for other ports
      auth: {
        user: "no_reply@talenttree.in", // generated ethereal user
        pass: "qEBjm5L97AD^", // generated ethereal password
      },
    });

    const mailOptions = {
      from: "no_reply@talenttree.in",
      to: email,
      subject: "OTP Verification",
      text: `Your OTP is: ${otp}`,
    };

    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.log("Error sending email:", error);
        // Handle error case, such as returning an error response to the client
      } else {
        console.log("Email sent:", info.response);
        // Handle success case, such as returning a success response to the client
      }
    });

    return res.json({ msg: "User created. Please check your email for OTP verification." });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});


// user routes
authRouter.post("/api/verify-otp", async (req, res) => {
  try {
    const { email, otp } = req.body;

    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({ msg: "User not found." });
    }

    if (user.otp !== otp) {
      return res.status(400).json({ msg: "Invalid OTP." });
    }

    if (user.otpExpiry < Date.now()) {
      return res.status(400).json({ msg: "OTP has expired." });
    }

    user.otp = undefined;
    user.otpExpiry = undefined;
    user.isVerified = true;

    await user.save();

    return res.json({ msg: "OTP verified successfully." });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

authRouter.post("/api/resend-otp", async (req, res) => {
  try {
    const { email } = req.body;

    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({ msg: "User not found." });
    }

    if (user.isVerified) {
      return res.status(400).json({ msg: "User is already verified." });
    }

    const otp = otpGenerator.generate(6, { alphabets: false, upperCase: false, specialChars: false });
    const otpExpiry = Date.now() + 600000; // OTP expiry set to 10 minutes from now

    user.otp = otp;
    user.otpExpiry = otpExpiry;

    await user.save();

    // Send the new OTP to the user's email
    const transporter = nodemailer.createTransport({
      host: "server51.babyhost.in",
      port: 465,
      secure: true, // true for 465, false for other ports
      auth: {
        user: "no_reply@talenttree.in", // generated ethereal user
        pass: "qEBjm5L97AD^", // generated ethereal password
      },
    });

    const mailOptions = {
      from: "your_email@example.com",
      to: email,
      subject: "OTP Verification",
      text: `Your new OTP is: ${otp}`,
    };

    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.log("Error sending email:", error);
        // Handle error case, such as returning an error response to the client
      } else {
        console.log("Email sent:", info.response);
        // Handle success case, such as returning a success response to the client
      }
    });

    return res.json({ msg: "New OTP has been sent to your email." });
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


// Resend Otp
authRouter.post("/api/resend-otp", async (req, res) => {
  try {
    const { email } = req.body;

    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({ msg: "User not found." });
    }

    if (user.isVerified) {
      return res.status(400).json({ msg: "User is already verified." });
    }

    const otp = otpGenerator.generate(6, { alphabets: false, upperCase: false, specialChars: false });
    const otpExpiry = Date.now() + 600000; // OTP expiry set to 10 minutes from now

    user.otp = otp;
    user.otpExpiry = otpExpiry;

    await user.save();

    // Send the new OTP to the user's email
    const transporter = nodemailer.createTransport({
      // Configure your email transport settings here (e.g., SMTP)
    });

    const mailOptions = {
      from: "your_email@example.com",
      to: email,
      subject: "OTP Verification",
      text: `Your new OTP is: ${otp}`,
    };

    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.log("Error sending email:", error);
        // Handle error case, such as returning an error response to the client
      } else {
        console.log("Email sent:", info.response);
        // Handle success case, such as returning a success response to the client
      }
    });

    return res.json({ msg: "New OTP has been sent to your email." });
  } catch (e) {
    return res.status(500).json({ error: e.message });
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

  if (!user) {
    return res.status(400).json({ msg: "User not found." });
  }
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
