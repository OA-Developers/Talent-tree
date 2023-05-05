const express = require("express");
const Banner = require("../models/banner");
const multer = require('multer');
const path = require('path');

const bannerRouter = express.Router();

// File upload
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.resolve(__dirname, "../../public"));
    },
    filename: function (req, file, cb) {
        const ext = file.mimetype.split("/")[1];
        const prefix = file.mimetype.startsWith("image") ? "banner" : "video";
        const filename = `${prefix}-${file.fieldname}-${Date.now()}.${ext}`;

        if (file.fieldname === "thumbnail") {
            req.savedThumbnailFilename = filename;
            cb(null, `thumbnails/${filename}`);
        } else {
            req.savedFilename = filename;
            cb(null, `${file.fieldname}s/${filename}`);
        }
    }
});

const upload = multer({ storage: storage });

// Image upload route
bannerRouter.post('/banner/image/upload', upload.single('file'), async (req, res) => {
    try {
        const file = new Banner({
            name: req.body.title,
            size: req.file.size,
            type: req.body.type,
            url: req.savedFilename,
        });

        await file.save();
        res.status(200).json({ msg: "Image uploaded successfully" });
    } catch (err) {
        console.error("Error uploading image:", err);
        res.status(500).json({ msg: "Server error" });
    }
});

// Video upload route
bannerRouter.post('/banner/video/upload', upload.fields([{ name: 'file', maxCount: 1 }, { name: 'thumbnail', maxCount: 1 }]), async (req, res) => {
    try {
        const videoFile = req.files['file'][0];
        const thumbnailFile = req.files['thumbnail'][0];

        const file = new Banner({
            name: req.body.title,
            size: videoFile.size,
            type: req.body.type,
            url: req.savedFilename,
            thumbnailUrl: thumbnailFile ? req.savedThumbnailFilename : null
        });

        await file.save();
        res.status(200).json({ msg: "Video uploaded successfully" });
    } catch (err) {
        console.error("Error uploading video:", err);
        res.status(500).json({ msg: "Server error" });
    }
});

bannerRouter.get('/banners', async (req, res) => {
    const banners = await Banner.find();
    res.json(banners);
});

bannerRouter.delete('/banner/:id', async (req, res) => {
    try {
        const banner = await Banner.findByIdAndDelete(req.params.id);
        if (!banner) {
            return res.status(404).json({ msg: 'Banner not found' });
        }
        res.json({ msg: 'Banner deleted successfully' });
    } catch (error) {
        console.error('Error deleting banner:', error);
        res.status(500).json({ msg: 'Server error' });
    }
});

bannerRouter.use('/files', express.static(path.resolve(__dirname, '../../public/files')));
bannerRouter.use('/thumbnails', express.static(path.resolve(__dirname, '../../public/thumbnails')));

module.exports = bannerRouter;
