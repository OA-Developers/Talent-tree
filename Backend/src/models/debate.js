const mongoose = require("mongoose");

const debateSchema = mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    type: {
        type: String,
        required: true
    },
    videoUrl: {
        type: String,
        required: true
    },
    thumbnailUrl: {
        type: String
    },
});

const Debate = mongoose.model('Debate', debateSchema);
module.exports = Debate;