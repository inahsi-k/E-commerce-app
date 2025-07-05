const express = require('express');
const router = express.Router();
const Product = require('../model/product');
const multer = require('multer');
const { uploadProduct } = require('../uploadFile');
const asyncHandler = require('express-async-handler');

router.get('/', asyncHandler(async (req, res) => {
    try {
        const products = await Product.find()
        .populate('proCategoryId', 'id name')  //category schema se bas name aur id hi add karo products mein ,not the extra info like  v,createdat ....
        .populate('proSubCategoryId', 'id name')
        .populate('proBrandId', 'id name')
        .populate('proVariantTypeId', 'id type')
        .populate('proVariantId', 'id name');
        res.json({ success: true, message: "Products retrieved successfully.", data: products });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));


router.get('/:id', asyncHandler(async (req, res) => {
    try {
        const productID = req.params.id;
        const product = await Product.findById(productID)
            .populate('proCategoryId', 'id name')
            .populate('proSubCategoryId', 'id name')
            .populate('proBrandId', 'id name')
            .populate('proVariantTypeId', 'id name')
            .populate('proVariantId', 'id name');
        if (!product) {
            return res.status(404).json({ success: false, message: "Product not found." });
        }
        res.json({ success: true, message: "Product retrieved successfully.", data: product });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));


router.post('/',asyncHandler(async(req,res)=>{
    try{
        uploadProduct.fields([
        {name:'image 1', maxCount:1},
        {name:'image 2', maxCount:1},
        {name:'image 3', maxCount:1},
        {name:'image 4', maxCount:1},
        {name:'image 5', maxCount:1}
        ])(req,res,async(err)=>{
            if(err){
                if(err.code=='LIMIT_FILE_SIZE') return res.json({success:false,message:"File size larger than 5 MB"});
                return res.json({success:false,message:err.message});
            }
            const{name,price,quantity,offerPrice,proCategoryId,proSubCategoryId,proBrandId, proVariantTypeId,proVariantId,description}=req.body;

            if (!name || !quantity || !price || !proCategoryId || !proSubCategoryId) {
                    return res.status(400).json({ success: false, message: "Required fields are missing." });
            }
            const images=[];
            const fields=['image1','image 2','image 3','image 4','image 5'];

            // let count= 0; // as const wont support count++
            // for(const field of fields){
            //     if(req.files && req.files[field].length>0){
            //         const imageUrl=`http://localhost:3000/public/product/${req.files[field][0]['filename']}`;
            //         count ++;
            //         images.push({name:count,url:imageUrl});
            //     }
            // }

            fields.forEach((field, index) => {
                if (req.files[field] && req.files[field].length > 0) {
                    const file = req.files[field][0];
                    const imageUrl = `http://localhost:3000/image/products/${file.filename}`;
                    images.push({ image: index + 1, url: imageUrl });
                }
            });

            const product= await new Product({name, description, quantity, price, offerPrice, proCategoryId, proSubCategoryId, proBrandId,proVariantTypeId, proVariantId, images: imageUrls});
            const newProduct= product.save();
            return res.status(200).json({success:true, message:"new product added successfully", data:newProduct});
        })
    }catch(err){
        res.status(500).json({ success: false, message: error.message });
    }
}))


router.put('/:id',asyncHandler(async(req,res)=>{
    try{
        uploadProduct.fields([
        {name:'image1', maxCount:1},
        {name:'image2', maxCount:1},
        {name:'image3', maxCount:1},
        {name:'image4', maxCount:1},
        {name:'image5', maxCount:1}
        ])
        if(err){
            if(err.code=='LIMIT_FILE_SIZE') return res.json({success:false,message:"File size larger than 5 MB"});
            return res.json({success:false,message:err.message});
        }
        const id=req.params.id;
        const{name,price,quantity,offerPrice,proCategoryId,proSubCategoryId,proBrandId, proVariantTypeId,proVariantId,description}=req.body;
        const product = await Product.findById(id);
        if(!product) return res.status(404).json({success: false, message:'Product not found'})

        let  updatableFields=['name','price','quantity','offerPrice','proCategoryId','proSubCategoryId','proBrandId', 'proVariantTypeId','proVariantId','description'];
        updatableFields.forEach((field,index)=>{
            if(req.body[field]!== undefined) product[field]=req.body[field];
        })

        const fields=['image1','image2','image3','image4','image5'];
        if(!product.images) product.images=[];
        fields.forEach((field, index)=>{
            if(req.files && req.files[field].length>0) {
                const filename=req.files[field][0].filename;
                const imageUrl=`http://localhost:3000/public/product/${filename}`;
                
                const existingIndex=product.images.findIndex((img)=>img.image===index+1);
                if(exisTingIndex!==-1){
                    product.images[existingIndex].url = imageUrl;
                }else{
                    product.images.push({image:index+1,url:imageUrl});
                }
            }
        });
        await product.save();
        return res.json({
            success: true,
            message: "Product updated successfully",
            data: product
        });
        
    }catch(err){
        res.status(500).json({ success: false, message: error.message });
    }
}));


router.delete('/:id', asyncHandler(async (req, res) => {
    const productID = req.params.id;
    try {
        const product = await Product.findByIdAndDelete(productID);
        if (!product) {
            return res.status(404).json({ success: false, message: "Product not found." });
        }
        res.json({ success: true, message: "Product deleted successfully." });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
}));

module.exports = router;
