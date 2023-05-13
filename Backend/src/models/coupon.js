const mongoose = require("mongoose");

const couponSchema = mongoose.Schema({
    code: {
        type: String,
        required: true,
    },
    expiry: {
        type: Date,
        required: true,
    },
    discount: {
        type: String,
        required: true,
    }
})

const Coupon = mongoose.model("Coupon", couponSchema);
module.exports = Coupon;
