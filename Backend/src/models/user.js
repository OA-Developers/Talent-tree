const mongoose = require("mongoose");

const subscriptionSchema = mongoose.Schema({
  plan: {
    type: String,
    required: true,
  },
  startDate: {
    type: Date,
    required: true,
  },
  endDate: {
    type: Date,
    required: true,
  },
});

const userSchema = mongoose.Schema({
  name: {
    type: String,
  },
  password: {
    required: true,
    type: String,
  },
  mobile: {
    required: true,
    type: Number,
  },
  isVerified: {
    type: Boolean,
    default: false,
  },
  subscription: {
    type: subscriptionSchema,
    default: null,
  },
  profileImage: {
    type: String,
    default: null,
  },
});

const User = mongoose.model("User", userSchema);
module.exports = User;
