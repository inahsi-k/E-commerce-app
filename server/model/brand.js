const mongoose = require('mongoose');

const brandSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'Name is required'], 
        trim: true
    },
    subcategoryId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'subCategory', // This should match the model name you use when you create the SubCategory model
        required: [true, 'Subcategory ID is required']
    }
},{ timestamps: true });


const Brand = mongoose.model('brand', brandSchema);

module.exports = Brand;
