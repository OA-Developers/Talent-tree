const express = require("express");
const Banner = require("../models/banner")
const multer = require('multer');
const path = require('path');


const bannerRouter = express.Router();

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.join(__dirname, '/uploads/'));
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + '-' + file.originalname);
    }
});
const upload = multer({ storage: storage });


bannerRouter.post('/admin/upload', upload.single('file'), async (req, res) => {
    const file = new Banner({
        name: req.file.originalname,
        size: req.file.size,
        type: req.file.mimetype,
        url: req.file.path,
    });
    await file.save();
    res.send(file);
});

bannerRouter.get('/files/:id', async (req, res) => {
    const file = await File.findById(req.params.id);
    res.sendFile(file.url);
});

module.exports = bannerRouter;