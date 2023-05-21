const mongoose = require("mongoose");

const actingOpeningSchema = mongoose.Schema({
  title: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  source: {
    type: String,
    required: true
  },
  category: {
    type: String,
    required: true,
    lowercase: true,
  },
  imageUrl: {
    type: String,
    required: true
  },
  location: {
    type: String,
    required: true
  },
  time: {
    type: Date,
    default: Date.now
  },
  email: {
    type: String,
    required: true,
    lowercase: true,
    trim: true,
    match: [/^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/, 'Please fill a valid email address']
  },
  whatsAppNumber: {
    type: String,
    required: true
  },
});

const ActingOpening = mongoose.model('ActingOpening', actingOpeningSchema);
module.exports = ActingOpening;
