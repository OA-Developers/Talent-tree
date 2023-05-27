const mongoose = require("mongoose");

const settingsSchema = new mongoose.Schema({

    name: {
        type: String,
    },
    adBanner: {
        type: String,
    },
    tvBanner: {
        type: String,
    },
    webBanner: {
        type: String,
    }
})
const Settings = mongoose.model("Settings", settingsSchema);
module.exports = Settings;
