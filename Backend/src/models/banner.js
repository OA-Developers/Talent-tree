const mongoose = require("mongoose");

const bannerSchema = mongoose.Schema({
    name: String,
    size: Number,
    type: String,
    url: String,
    thumbnailUrl: {
        type: String
    },
});

const Banner = mongoose.model('Banner', bannerSchema);
module.exports = Banner;