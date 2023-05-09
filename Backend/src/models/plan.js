const mongoose = require("mongoose")

const planSchema = mongoose.Schema({
    price: {
        type: String,
        required: true
    },
    duration: {
        type: Number,
        required: true
    }
})

const Plan = mongoose.model('Plan', planSchema);
module.exports = Plan;