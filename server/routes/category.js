const express= require('express');
const router=express.Router();
const Category=require('../model/category');
const {uploadCategory}= require('../config/multerConfig');
const asyncHandler = require('express-async-handler');
const multer = require('multer');
const Product = require('../model/product');
const SubCategory = require('../model/subcategory');
const Brand = require('../model/brand');

router.get('/',asyncHandler(async(req,res)=>{
    try{
        const categories= await Category.find();
        return res.json({
            success:"true",
            message:"categories found successfully",
            body:categories
        })
    }catch(err){
        return res.status(500).json({
            success:"false",
            message:`Fields problem: ${err.message}`
        })
    }
}))


router.get('/:id',asyncHandler(async(req,res)=>{
    try{
        const id=req.params.id;
        const category= await Category.findById({id})
    if(!category) return res.status(404).json({
        success:"false",
        message:"Category not found",
    })

    res.json({ success: true, message: "Category retrieved successfully.", data: category });

    }catch(err){
        return res.status(500).json({
            success:"false",
            message:`Fields problems: ${err.message}`
        })
    }
}))


router.post('/',asyncHandler(async(req,res)=>{
    try{
        uploadCategory.single('img')(req, res,async(err)=>{
            if (err) {
                if (err.code === 'LIMIT_FILE_SIZE') {
                    err.message = 'File size is too large. Maximum filesize is 5MB.';
                }
            return res.status(400).json({ success: false, message: err.message });
            }

            const {name}=req.body;
            if(!name) return res.json({success: true, message: "Name is required"});
            let imageUrl='no_url';
            if(req.file) imageUrl = `http://localhost:3000/image/category/${req.file.filename}`;
            console.log('url',imageUrl);

            try{
                const category=await new Category({
                    name:name,
                    image:imageUrl
                }).save();
                
                res.status(200).json({ success: true, message: "Category created successfully.", data: category });

            }catch(err){
                return res.status(500).json({
                    success:"false",
                    message:`Fields problems: ${err.message}`
                })
            }
    })
    }catch(err){
        return res.status(500).json({
            success:"false",
            message:`Fields problems: ${err.message}`
        })
    }
}))


router.put('/:id',asyncHandler(async(req,res)=>{
    try{
        uploadCategory.single('img')(req,res, async(err)=>{
        if(err){
            if(err.code=='LIMIT_FILE_SIZE') return res.status(400).json({success:false,message:"file size larger than 5 MBs"});
            return res.status(400).json({success:false,message:err.message});
        }
        const {id}=req.params;
        const {name,image}=req.body;
        if(req.file) image=`http://localhost:3000/image/category/${req.file.filename}`;
        if(!name|!image) return res.status(400).json({success:false,message:"Name and image are required"});
        try{
            const updateCategory=await Category.findByIdAndUpdate(id,{$set:{name,image}},{new:true});
            if(!updateCategory) return res.status(404).json({success:false,message:"category not found"});
            return res.json({success:true,message:"Category updated successfully",data:updateCategory});
        }catch(err){
            return res.status(500).json({
                success:"false",
                message:err.message
            })
        }})
    }catch(err){
        return res.status(500).json({
            success:"false",
            message:err.message
        })
    }
}));



router.delete('/:id',async (req,res)=>{
    try{
        const {id}=req.params;
        const product=await Product.find({proCategoryId:id});
        if(product.length>0) return res.status(400).json({success:false,message:"Can't delete category, there are products referencing it"});
        
        const subCategory=await SubCategory.find({categoryId:id});
        if(subCategory.length>0) return res.status(400).json({success:false,message:"Can't delete category, there are subcategories referencing it"});

        const category=await Category.findByIdAndDelete(id);
        if (!category) {
            return res.status(404).json({ success: false, message: "Category not found." });
        }
        res.json({ success: true, message: "Category deleted successfully." });
    }catch(err){
        return res.status(500).json({
            success:"false",
            message:err.message
        })
    }
})

module.exports= router;
