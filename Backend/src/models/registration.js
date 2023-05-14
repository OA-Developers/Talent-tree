const mongoose = require("mongoose");

const registrationSchema = mongoose.Schema({
    userId: {
        type: String,
        required: true,
    },
    fullName: {
        type: String,
        required: true,
    },
    gender: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        validate: {
            validator: (value) => {
                const ex =
                    /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
                return value.match(ex);
            },
            message: "Please enter a valid email address",
        },
    },
    mobile: {
        type: String,
        required: true,
    },
    mobileAlt: {
        type: String,
    },
    dob: {
        type: String,
        required: true,
    },
    state: {
        type: String,
        required: true,
    },
    city: {
        type: String,
        required: true,
    },
    currentCity: {
        type: String,
        required: true,
    },
    height: {
        type: String,
        required: true,
    },
    experience: {
        type: String,
    },
    video: {
        type: String,
    },
    audio: {
        type: String,
    },
    image: {
        type: String,
    },
    docs: {
        type: String,
    },


})

const Registration = mongoose.model("Registration", registrationSchema);
module.exports = Registration