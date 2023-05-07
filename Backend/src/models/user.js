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
  password: {
    required: true,
    type: String,
  },

  subscription: {
    type: subscriptionSchema,
    default: null,
  },
});

const User = mongoose.model("User", userSchema);
module.exports = User;
