const express = require('express');
const router = express.Router();
const Category = require('../model/category');
const SubCategory = require('../model/subcategory');
const Product = require('../model/product');
//const { uploadCategory } = require('../uploadFile');
//const multer = require('multer');
const asyncHandler = require('express-async-handler');

router.get('/',asyncHandler(async(req,res)=>{
    try{
        const subCategories = await SubCategory.find().populate('categoryId').sort({'categoryId': 1}); // sorts the sub-categories by their categoryId in ascending order (1 = ascending, -1 = descending).
        res.json({ success: true, message: "SubCategories retrieved successfully.", data: subCategories });
    }catch(err){
        res.status(500).json({ success: false, message: err.message });
    }
}));

router.get('/:id', asyncHandler(async (req, res) => {
    try {
        const subCategoryID = req.params.id;
        const subCategory = await SubCategory.findById(subCategoryID).populate('categoryId'); //populate will give all the data(name, image) related to the category as subcategory was ref' it
        if (!subCategory) {
            return res.status(404).json({ success: false, message: "Sub-category not found." });
        }
        res.json({ success: true, message: "Sub-category retrieved successfully.", data: subCategory });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));

router.post('/', asyncHandler(async (req, res) => {
    const { name, categoryId } = req.body;
    if (!name || !categoryId) {
        return res.status(400).json({ success: false, message: "Name and category ID are required." });
    }
    try {
        const subCategory = new SubCategory({ name, categoryId }); //returns wont show v timestamps and not yet saved in db, id not passed to db
        const newSubCategory = await subCategory.save(); // returns full data with created at ,updated at
        res.json({ success: true, message: "Sub-category created successfully.", data:newSubCategory });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));

router.put('/:id',asyncHandler(async(req,res)=>{
    const {name, categoryId}=req.body;
    const {id}=req.params.id;
    if(!name|!categoryId) return res.status(400).json({ success: true, message: "Name and category ID are required." });
    try{
        const updatedSubCategory=await SubCategory.findByIdAndUpdate(id,{name,categoryId},{new:true});
        if (!updatedSubCategory) return res.status(404).json({ success: false, message: "Sub-category not found." });
        res.json({ success: true, message: "Sub-category created successfully.", data:updatedSubCategory });
    }catch(err){
        res.status(500).json({ success: false, message: error.message });

    }
}));

router.delete('/:id', asyncHandler(async (req, res) => {
    const subCategoryID = req.params.id;
    try {
        const brandCount = await Brand.countDocuments({ subcategoryId: subCategoryID });  //just the no. of documents, find was retrun array of data which is unnecessary so here cdoc is better option
        if (brandCount > 0) {
            return res.status(400).json({ success: false, message: "Cannot delete sub-category. It is associated with one or more brands." });
        }

        const products = await Product.countDocuments({ proSubCategoryId: subCategoryID });
        if (products > 0) {
            return res.status(400).json({ success: false, message: "Cannot delete sub-category. Products are referencing it." });
        }

        const subCategory = await SubCategory.findByIdAndDelete(subCategoryID);
        if (!subCategory) {
            return res.status(404).json({ success: false, message: "Sub-category not found." });
        }
        res.json({ success: true, message: "Sub-category deleted successfully." });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));

module.exports=router;