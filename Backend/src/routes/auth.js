const express = require("express");
const bcrypt = require("bcrypt");
const otpGenerator = require("otp-generator");
const nodemailer = require("nodemailer");
const User = require("../models/user");
const adminUser = require("../models/adminUser");
const Registration = require("../models/registration");
const axios = require('axios');
const jwt = require("jsonwebtoken");
const authRouter = express.Router();

const auth = require("../middlewares/auth")

const senderId = 'TLNTRE';
const templateId = '1207168569170029235';
const username = 'talenttree';
const apiKey = 'F97A2-4FC00';
const uri = 'http://www.alots.in/sms-panel/api/http/index.php';

const assignedPassphrase = 'TALENT_TREE_MOBILE';

authRouter.post('/send-otp', (req, res) => {
  const { phone, passphrase,otp } = req.body;

  const msg = `Please use ${otp} as OTP to log on to Talenttree.`;

  if (phone.length === 10 && passphrase.length > 0 && passphrase === assignedPassphrase) {
    const data = {
      username: username,
      apikey: apiKey,
      apirequest: 'Text/Unicode',
      sender: senderId,
      route: 'route name', // You may need to update this
      format: 'JSON',
      message: msg,
      mobile: phone,
      TemplateID: templateId,
    };

    axios.post(uri, data)
      .then(response => {
        res.json({ resp: response.data, error: null });
      })
      .catch(error => {
        res.json({ resp: null, error: error.message });
      });
  } else {
    res.json({ error: 'Invalid phone number length or passphrase' });
  }
});

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


authRouter.post("/api/signup", async (req, res) => {
  try {
    const { mobile, password } = req.body;
    const name = `Talent${getRandomNumber(1, 10000)}`;

    const existingUser = await User.findOne({ mobile });
    if (existingUser) {
      return res.status(400).json({ msg: "User with the same mobile already exists!" });
    }

    // const otp = otpGenerator.generate(6, { alphabets: false, upperCase: false, specialChars: false });
    // const otpExpiry = Date.now() + 600000; // OTP expiry set to 10 minutes from now

    const hashedPassword = await bcrypt.hash(password, 8);

    let user = new User({
      name,
      password: hashedPassword,
      mobile,
      otp,
      otpExpiry,
      profileImage: ""
    });
    user = await user.save();

    // Send OTP to the user's email
    // const transporter = nodemailer.createTransport({
    //   host: "mail.talenttree.in",
    //   port: 465,
    //   secure: true, // true for 465, false for other ports
    //   auth: {
    //     user: "no_reply@talenttree.in", // generated ethereal user
    //     pass: "qEBjm5L97AD^", // generated ethereal password
    //   },
    // });

    // const mailOptions = {
    //   from: "no_reply@talenttree.in",
    //   to: email,
    //   subject: "OTP Verification",
    //   text: `Your OTP is: ${otp}`,
    // };

    // transporter.sendMail(mailOptions, (error, info) => {
    //   if (error) {
    //     console.log("Error sending email:", error);
    //     // Handle error case, such as returning an error response to the client
    //   } else {
    //     console.log("Email sent:", info.response);
    //     // Handle success case, such as returning a success response to the client
    //   }
    // });

    return res.json({ msg: "User created." });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});


// user routes



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
