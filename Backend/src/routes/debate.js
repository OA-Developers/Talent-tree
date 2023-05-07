const express = require("express");
const Debate = require("../models/debate");
const multer = require('multer');
const path = require('path');

const debateRouter = express.Router();

// File upload
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.resolve(__dirname, "../../public"));
    },
    filename: function (req, file, cb) {
        const ext = file.mimetype.split("/")[1];
        const prefix = file.mimetype.startsWith("image") ? "thumbnail" : "debate";
        const filename = `${prefix}-${file.fieldname}-${Date.now()}.${ext}`;

        if (file.fieldname === "thumbnail") {
            req.savedThumbnailFilename = filename;
            cb(null, `thumbnails/${filename}`);
        } else {
            req.savedFilename = filename;
            cb(null, `files/${filename}`);
        }
    }
});

const upload = multer({ storage: storage });

// Video upload route
debateRouter.post('/debate/upload/file', upload.fields([{ name: 'file', maxCount: 1 }, { name: 'thumbnail', maxCount: 1 }]), async (req, res) => {
    try {
        const { title, description, } = req.body;
        const thumbnailUrl = `thumbnails/${req.savedThumbnailFilename}`;
        const videoUrl = `files/${req.savedFilename}`;

        const debate = new Debate({
            title,
            description,
            type: 'upload',
            videoUrl,
            thumbnailUrl
        });

        await debate.save();

        res.json({ msg: 'Debate created successfully' });
    } catch (err) {
        console.error("Error creating debate:", err);
        res.status(500).json({ msg: "Server error" });
    }
});

debateRouter.post('/debate/upload/link', upload.fields([{ name: 'thumbnail', maxCount: 1 }]), async (req, res) => {
    try {
        const { title, description, videoLink } = req.body;
        const thumbnailUrl = `thumbnails/${req.savedThumbnailFilename}`;

        const debate = new Debate({
            title,
            description,
            type: 'link',
            videoUrl: videoLink,
            thumbnailUrl
        });

        await debate.save();

        res.json({ msg: 'Debate created successfully' });
    } catch (err) {
        console.error("Error creating debate:", err);
        res.status(500).json({ msg: "Server error" });
    }
});



debateRouter.get('/debates', async (req, res) => {
    const debates = await Debate.find();
    res.json(debates);
});

debateRouter.delete('/debate/:id', async (req, res) => {
    try {
        const debate = await Debate.findByIdAndDelete(req.params.id);
        if (!debate) {
            return res.status(404).json({ msg: 'Debate not found' });
        }
        res.json({ msg: 'Debate deleted successfully' });
    } catch (error) {
        console.error('Error deleting debate:', error);
        res.status(500).json({ msg: 'Server error' });
    }
});


module.exports = debateRouter;
