const express = require("express");
const Banner = require("../models/banner")
const multer = require('multer');
const path = require('path');



const bannerRouter = express.Router();

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.join(__dirname, "../../public"));
    },
    filename: function (req, file, cb) {
        const ext = file.mimetype.split("/")[1];
        const filename = `banner-${file.fieldname}-${Date.now()}.${ext}`;
        cb(null, `banners/${filename}`);
        req.savedFilename = filename;
    }
});
const upload = multer({ storage: storage });


bannerRouter.post('/banner/upload', upload.single('file'), async (req, res) => {
    const file = new Banner({
        name: req.body.title,
        size: req.file.size,
        type: req.body.type,
        url: req.savedFilename,
    });
    await file.save();
    res.status(200).json({
        msg: "Files Uploaded Successfuly"
    })
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



bannerRouter.use('/files', express.static(path.join(__dirname, '../../public/banners')));


module.exports = bannerRouter;