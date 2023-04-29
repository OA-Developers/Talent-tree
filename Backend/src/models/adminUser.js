const mongoose = require("mongoose")

const adminUserSchema = mongoose.Schema({
    name: {
        type: String
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
    pasword: {
        type: String,
        required: true,
    },
    role: {
        type: String
    }
})

const adminUser = mongoose.model('adminUser', adminUserSchema);
module.exports = adminUser;