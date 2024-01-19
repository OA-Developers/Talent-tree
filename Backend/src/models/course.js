const mongoose = require("mongoose")

const courseSchema  = mongoose.Schema({
    title:{
        type:String,
        required:true,
    },
    price:{
        type:String,
        required:true,
    },
    description:{
        type:String,
        required:true,
    },
    timing:{
        type:String,
        required:true,
    },
    duration:{
        type:String,
        required:true,
    }



})

const Course = mongoose.model('Course',courseSchema);

module.exports = Course