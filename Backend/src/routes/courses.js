const express = require("express")
const Course = require("../models/course")

const coursesRouter = express.Router()

coursesRouter.get('/getAllCourses',async (req,res)=>{
    const response = Course.find()
    
})
