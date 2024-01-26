const express = require("express");
const User = require("../models/user");
const Coupon = require("../models/coupon");
const Registration = require("../models/registration");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");
const userRouter = express.Router();
const multer = require("multer");
const path = require("path");
const crypto = require("crypto");
const Transaction = require("../models/transactions");
const Debate = require("../models/debate");

// Check if user is subscribed and has access to feature

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.resolve(__dirname, "../../public"));
  },
  filename: function (req, file, cb) {
    const ext = file.mimetype.split("/")[1];
    const prefix = file.mimetype.startsWith("image") ? "thumbnail" : "debate";
    const randomString = crypto.randomBytes(8).toString("hex");
    const filename = `${prefix}-${file.fieldname}-${randomString}.${ext}`;

    switch (file.fieldname) {
      case "image":
        req.savedImageFilename = filename;
        cb(null, `files/${filename}`);
        break;
      case "video":
        req.savedVideoFilename = filename;
        cb(null, `files/${filename}`);
        break;
      case "audio":
        req.savedAudioFilename = filename;
        cb(null, `files/${filename}`);
        break;
      case "docs":
        req.savedDocsFilename = filename;
        cb(null, `files/${filename}`);
        break;
      default:
        cb(new Error("Invalid fieldname"));
    }
  },
});

const upload = multer({ storage: storage });

userRouter.get("/checkSubscribed", auth, async (req, res) => {
  try {
    const userId = req.user;
    const user = await User.findById(userId);
    if (user.subscription === null) {
      res.status(403).json({ message: "You are not subscribed to any plan" });
    } else {
      const currentDate = new Date();
      const endDate = new Date(user.subscription.endDate);
      if (currentDate > endDate) {
        await User.findByIdAndUpdate(userId, { subscription: null });
        res.status(403).json({ message: "Your subscription has expired" });
      } else {
        res
          .status(200)
          .json({ message: "You are currently subscribed to a plan" });
      }
    }
  } catch (error) {
    console.error("Error checking subscription:", error);
    res.sendStatus(500);
  }
});

userRouter.post("/subscribe", auth, async (req, res) => {
  try {
    const userId = req.user;
    const { duration, paid } = req.body;
    const user = await User.findById(userId);
    if (user.subscription === null) {
      const endDate = new Date(Date.now() + duration * 24 * 60 * 60 * 1000);
      await User.updateOne(
        { _id: userId },
        {
          $set: {
            subscription: {
              plan: "basic", // Update the plan type as required
              startDate: new Date(),
              endDate: endDate,
            },
          },
        }
      );
      // add transaction
      const description = "Audience Subscription";
      const amount = paid ? req.price : "0";
      const mode = paid ? "UPI" : "Coupon";
      const status = "PAID";
      const transaction = new Transaction({
        userId,
        description,
        amount,
        mode,
        status,
      });
      await transaction.save();
      res.status(200).json({ msg: "Successfully subscribed to the plan" });
    } else {
      res.status(400).json({ msg: "You already have an active subscription" });
    }
  } catch (e) {
    console.error(e);
    res.sendStatus(500);
  }
});

userRouter.post(
  "/update-profile",
  auth,
  upload.single("image"),
  async (req, res) => {
    try {
      const userId = req.user;
      const { name } = req.body;

      const user = await User.findById(userId);
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }
      if (req.file) {
        // Update the image path if a new image is uploaded
        user.profileImage = req.savedImageFilename;
      }

      // Update the name and email
      user.name = name;

      await user.save();

      res.json({ message: "Profile updated successfully" });
    } catch (error) {
      console.error("Error updating profile:", error);
      res.sendStatus(500);
    }
  }
);

userRouter.post(
  "/register",
  auth,
  upload.fields([
    { name: "audio", maxCount: 1 },
    { name: "video", maxCount: 1 },
    { name: "image", maxCount: 1 },
    { name: "docs", maxCount: 1 },
  ]),
  async (req, res) => {
    try {
      const {
        fullName,
        gender,
        email,
        mobile,
        mobileAlt,
        dob,
        state,
        district,
        city,
        currentCity,
        height,
        experience,
      } = req.body;
      const userId = req.user;
      const registration = new Registration({
        fullName,
        gender,
        email,
        mobile,
        mobileAlt,
        dob,
        state,
        district,
        city,
        currentCity,
        height,
        experience,
        userId,
      });

      if (req.files.image) {
        registration.image = req.savedImageFilename;
      }

      if (req.files.video) {
        registration.video = req.savedVideoFilename;
      }

      if (req.files.audio) {
        registration.audio = req.savedAudioFilename;
      }

      if (req.files.docs) {
        registration.docs = req.savedDocsFilename;
      }

      await registration.save();

      res.json({ msg: "Registration created successfully" });
    } catch (error) {
      console.error("Error registering:", error);
      res.sendStatus(500);
    }
  }
);

userRouter.post("/apply-coupon", async (req, res) => {
  try {
    const { code } = req.body;
    console.log(code);

    // Find the coupon in the database
    const coupon = await Coupon.findOne({ code });

    // Check if the coupon exists and is not expired
    const now = new Date();
    if (!coupon || coupon.expiry < now) {
      return res.status(400).json({ msg: "Invalid coupon code" });
    }

    // Return the discount amount
    res.status(200).json({ discount: coupon.discount });
  } catch (err) {
    console.error("Error applying coupon:", err);
    res.status(500).json({ msg: "Server error" });
  }
});

userRouter.get("/getAllUsers", async (req, res) => {
  try {
    const users = await User.find({});
    if (users) {
      res.status(200).json({ users });
    } else {
      res.status(404).json({ msg: "No users found" });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ msg: "Server error" });
  }
});

userRouter.get("/getUserRegistration", async (req, res) => {
  const { userId } = req.query;
  try {
    const userRegistration = await Registration.find({ userId: userId });
    if (userRegistration) {
      res.status(200).json({ userRegistration });
    } else {
      res.status(404).json({ msg: "No registration found" });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ msg: "Server error" });
  }
});

userRouter.get("/getAllRegistrations", async (req, res) => {
  try {
    const registrations = await Registration.find({});
    if (registrations) {
      res.status(200).json({ registrations });
    } else {
      res.status(404).json({ msg: "No registrations found" });
    }
  } catch (e) {
    console.log(e);
    res.status(500).json({ msg: "Server error" });
  }
});
userRouter.get("/exportRegistrations", async (req, res) => {
  try {
    const data = await Registration.find({});
    res.json(data);
  } catch (e) {
    console.log(e);
    res.status(500).json({ msg: "Server error" });
  }
});
userRouter.get("/getAllTransactions", async (req, res) => {
  try {
    const data = await Transaction.find({});
    res.json(data);
  } catch (e) {
    console.log(e);
    res.status(500).json({ msg: "Server error" });
  }
});
userRouter.get("/getStats", async (req, res) => {
  try {
    const [totalAmountResult, debateCount, userCount, registrationCount] =
      await Promise.all([
        Transaction.aggregate([
          {
            $group: {
              _id: null,
              totalAmount: { $sum: "$amount" },
              monthlySum: {
                $sum: {
                  $cond: [
                    {
                      $gte: [
                        "$date",
                        new Date(new Date() - 30 * 24 * 60 * 60 * 1000),
                      ],
                    },
                    "$amount",
                    0,
                  ],
                },
              },
              weeklySum: {
                $sum: {
                  $cond: [
                    {
                      $gte: [
                        "$date",
                        new Date(new Date() - 7 * 24 * 60 * 60 * 1000),
                      ],
                    },
                    "$amount",
                    0,
                  ],
                },
              },
            },
          },
        ]),
        Debate.countDocuments({}),
        User.countDocuments({}),
        Registration.countDocuments({}),
      ]);

    const totalAmount = totalAmountResult?.[0]?.totalAmount || 0;
    const monthlySum = totalAmountResult?.[0]?.monthlySum || 0;
    const weeklySum = totalAmountResult?.[0]?.weeklySum || 0;

    res.json({ totalAmount, monthlySum, weeklySum, debateCount, userCount, registrationCount });
  } catch (error) {
    console.error("Error calculating total amount:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});


module.exports = userRouter;
