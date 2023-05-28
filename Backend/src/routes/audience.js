const moment = require('moment-timezone');
const express = require("express");
const ActingOpening = require("../models/audience");
const multer = require('multer');
const path = require('path');

const actingOpeningRouter = express.Router();

// File upload
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.resolve(__dirname, "../../public"));
    },
    filename: function (req, file, cb) {
        const ext = file.mimetype.split("/")[1];
        const filename = `opening-${file.fieldname}-${Date.now()}.${ext}`;

        if (file.fieldname === "image") {
            req.savedImageFilename = filename;
            cb(null, `files/${filename}`);
        }
    }
});

const upload = multer({ storage: storage });

actingOpeningRouter.post('/opening', upload.single('image'), async (req, res) => {
    try {
        const { title, description, source, category, location, email, whatsAppNumber } = req.body;
        const imageUrl = `files/${req.savedImageFilename}`;

        const opening = new ActingOpening({
            title,
            description,
            source,
            category,
            imageUrl,
            location,
            email,
            whatsAppNumber
        });

        await opening.save();

        res.json({ msg: 'Acting opening created successfully' });
    } catch (err) {
        console.error("Error creating acting opening:", err);
        res.status(500).json({ msg: "Server error" });
    }
});


actingOpeningRouter.get('/openings', async (req, res) => {
    try {
        const category = req.query.category;
        let openings;

        if (category) {
            openings = await ActingOpening.find({ category });
        } else {
            openings = await ActingOpening.find();
        }

        const convertedOpenings = openings.map(opening => {
            const convertedTime = moment(opening.time).tz('Asia/Kolkata').format('YYYY-MM-DD HH:mm:ss');
            return { ...opening._doc, convertedTime };
        });

        res.status(200).json(convertedOpenings);
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: "Internal server error" });
    }
});



actingOpeningRouter.put('/opening/:id', upload.single('image'), async (req, res) => {
    try {
        const { title, description, source, category, location, email, whatsAppNumber } = req.body;
        const imageUrl = req.savedImageFilename ? `files/${req.savedImageFilename}` : undefined;

        const updatedOpening = await ActingOpening.findByIdAndUpdate(req.params.id, {
            title,
            description,
            source,
            category,
            imageUrl,
            location,
            email,
            whatsAppNumber
        }, { new: true });

        if (!updatedOpening) {
            return res.status(404).json({ msg: 'Acting opening not found' });
        }

        return res.status(200).json({ msg: 'Acting opening updated successfully', opening: updatedOpening });
    } catch (err) {
        console.error("Error updating acting opening:", err);
        res.status(500).json({ msg: "Server error" });
    }
});

actingOpeningRouter.delete('/opening/:id', async (req, res) => {
    try {
        const opening = await ActingOpening.findByIdAndDelete(req.params.id);
        if (!opening) {
            return res.status(404).json({ msg: 'Acting opening not found' });
        }
        res.status(200).json({ msg: 'Acting opening deleted successfully' });
    } catch (error) {
        console.error('Error deleting acting opening:', error);
        res.status(500).json({ msg: 'Server error' });
    }
});

module.exports = actingOpeningRouter;
