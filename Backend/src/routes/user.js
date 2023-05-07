const express = require("express");
const User = require("../models/user");
const Registration = require("../models/registration");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");
const userRouter = express.Router();
const multer = require('multer');
const path = require('path');
const crypto = require('crypto');

// Check if user is subscribed and has access to feature

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.resolve(__dirname, "../../public"));
    },
    filename: function (req, file, cb) {
        const ext = file.mimetype.split("/")[1];
        const prefix = file.mimetype.startsWith("image") ? "thumbnail" : "debate";
        const randomString = crypto.randomBytes(8).toString('hex');
        const filename = `${prefix}-${file.fieldname}-${randomString}.${ext}`;

        switch (file.fieldname) {
            case 'image':
                req.savedImageFilename = filename;
                cb(null, `files/${filename}`);
                break;
            case 'video':
                req.savedVideoFilename = filename;
                cb(null, `files/${filename}`);
                break;
            case 'audio':
                req.savedAudioFilename = filename;
                cb(null, `files/${filename}`);
                break;
            case 'docs':
                req.savedDocsFilename = filename;
                cb(null, `files/${filename}`);
                break;
            default:
                cb(new Error('Invalid fieldname'));
        }
    }
});

const upload = multer({ storage: storage });

userRouter.get("/checkSubscribed", auth, async (req, res) => {
    try {
        const userId = req.user;
        const user = await User.findById(userId);
        if (user.subscription === null) {
            res.sendStatus(403);
        } else {
            const currentDate = new Date();
            const endDate = new Date(user.subscription.endDate);
            if (currentDate > endDate) {
                await User.findByIdAndUpdate(userId, { subscription: null });
                res.sendStatus(403);
            } else {
                res.sendStatus(200);
            }
        }
    } catch (error) {
        console.error("Error checking subscription:", error);
        res.sendStatus(500);
    }
});

userRouter.post("/register", auth, upload.fields([{ name: 'audio', maxCount: 1 }, { name: 'video', maxCount: 1 }, { name: 'image', maxCount: 1 }, { name: 'docs', maxCount: 1 }]), async (req, res) => {
    try {
        const { fullName, gender, email, mobile, mobileAlt, dob, state, district, city, currentCity, height, experience } = req.body;
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
            userId
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

        res.json({ msg: 'Registration created successfully' });

    } catch (error) {
        console.error("Error registering:", error);
        res.sendStatus(500);
    }
});

module.exports = userRouter;
