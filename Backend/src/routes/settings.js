const express = require("express");
const multer = require('multer');
const Settings = require("../models/settings")
const settingsRouter = express.Router();
const path = require('path');

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.resolve(__dirname, "../../public"));
    },
    filename: function (req, file, cb) {
        const ext = file.mimetype.split("/")[1];
        const prefix = file.mimetype.startsWith("image") ? "banner" : "video";
        const filename = `${prefix}-${file.fieldname}-${Date.now()}.${ext}`;

        req.savedFilename = filename;
        cb(null, `files/${filename}`);

    }
});

const upload = multer({ storage: storage });

settingsRouter.post("/settings/updateAdBanner", upload.single('file'), async (req, res) => {
    const id = req.body.id;
    try {
        let setting = await Settings.findOne({ name: "default" });

        if (setting) {
            setting.adBanner = req.savedFilename;
            await setting.save();
        } else {
            setting = new Settings({
                name: "default",
                adBanner: req.savedFilename
            });
            await setting.save();
        }
        res.status(200).json({ msg: "Image uploaded successfully" });
    } catch (error) {
        console.error("Error uploading image:", err);
        res.status(500).json({ msg: "Server error" });
    }
});
settingsRouter.post("/settings/updateTvBanner", upload.single('file'), async (req, res) => {
    try {
        let setting = await Settings.findOne({ name: "default" });

        if (setting) {
            setting.tvBanner = req.savedFilename;
            await setting.save();
        } else {
            setting = new Settings({
                name: "default",
                tvBanner: req.savedFilename
            });
            await setting.save();
        }
        res.status(200).json({ msg: "Image uploaded successfully" });
    } catch (error) {
        console.error("Error uploading image:", err);
        res.status(500).json({ msg: "Server error" });
    }
});
settingsRouter.post("/settings/updateWebBanner", upload.single('file'), async (req, res) => {
    try {
        let setting = await Settings.findOne({ name: "default" });

        if (setting) {
            setting.webBanner = req.savedFilename;
            await setting.save();
        } else {
            setting = new Settings({
                name: "default",
                webBanner: req.savedFilename
            });
            await setting.save();
        }
        res.status(200).json({ msg: "Image uploaded successfully" });
    } catch (error) {
        console.error("Error uploading image:", err);
        res.status(500).json({ msg: "Server error" });
    }
});

settingsRouter.get('/settings', async (req, res) => {
    const settings = await Settings.findOne({ name: "default" });
    res.json(settings);
});
module.exports = settingsRouter;

