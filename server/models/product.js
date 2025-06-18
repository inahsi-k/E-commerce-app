const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'Name is required'],
        trim: true
    },
    description: {
        type: String,
        trim: true
    },
    quantity: {
        type: Number,
        required: true
    },
    price: {
        type: Number,
        required: true
    },
    offerPrice: {
        type: Number
    },
    proCategoryId: {
        type: mongoose.Schema.Types.ObjectId, //help in filtering so all the 3 ids
        ref: 'category',
        required: true
    },
    proSubCategoryId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'subCategory',
        required: true
    },
    proBrandId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'brand'
    },
    proVariantTypeId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'variantType'
    },
    proVariantId: [String],
    images: [{
        image: {
            type: Number,
            required: true
        },
        url: {
            type: String,
            required: true
        }
    }]
}, { timestamps: true });

const Product = mongoose.model('product', productSchema);

module.exports = Product;
