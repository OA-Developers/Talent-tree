const mongoose = require("mongoose")

const transactionSchema = mongoose.Schema({
    
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    description: {
        type: String,
        required: true
    },
    amount: {
        type: String,
        required: true
    },
    mode: {
        type: String,
        required: true
    },
    status: {
        type: String,
        required: true
    }
})

const Transaction = mongoose.model('Transaction', transactionSchema);
module.exports = Transaction;