const express= require('express');
const router=express.Router();
const Category=require('../models/category');
const {uploadCategory}= require('../config/multerConfig');
const asyncHandler = require('express-async-handler');
const multer = require('multer');

router.get('/',asyncHandler(async(req,res)=>{
    try{
        const categories= await Category.find();
        return res.json({
            success:"true",
            message:"categories found successfully",
            body:categories
        })
    }catch(err){
        return res.statusCode(500).json({
            success:"false",
            message:err.message
        })
    }
}))

router.get('/:id',asyncHandler(async(req,res)=>{
    try{
        const id=req.params.id;
        const category= await Category.findById({id})
    if(!category) return res.statusCode(400).json({
        success:"false",
        message:"wrong id passed",
    })

    res.json({ success: true, message: "Category retrieved successfully.", data: category });

    }catch(err){
        return res.statusCode(500).json({
            success:"false",
            message:err.message
        })
    }
}))

router.post('/',asyncHandler(async(req,res)=>{
    try{
        uploadCategory.single('img')(req, res,(err)=>{
            if (err) {
                if (err.code === 'LIMIT_FILE_SIZE') {
                    err.message = 'File size is too large. Maximum filesize is 5MB.';
                }
            return res.json({ success: false, message: err.message });
            }

            const {name}=req.body;
            if(!name) return res.json({success: true, message: "Name is required"});
            let imageUrl='no_url';
            if(req.file) imageUrl = `http://localhost:3000/image/category/${req.file.filename}`;
            console.log('url',imageUrl);

            try{
                const category=new Category({
                    name:name,
                    image:imageUrl
                });
                category.save();
                res.statusCode(200).json({ success: true, message: "Category created successfully.", data: category });

            }catch(err){
                return res.statusCode(500).json({
                    success:"false",
                    message:err.message
                })
            }
    })
    }catch(err){
        return res.statusCode(500).json({
            success:"false",
            message:err.message
        })
    }
}))