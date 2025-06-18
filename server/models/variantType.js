const mongoose = require('mongoose');

//name-- color,size;  type(how variant will be presented in the ui)-- dropdown, checkbox

const variantTypeSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'Name is required'], 
        trim: true
    },
    type: {
        type: String,
        required: [true, 'Type is required'],
        trim: true
    }
},{ timestamps: true });

// Create the Variant model
const VariantType = mongoose.model('variantType', variantTypeSchema);

module.exports = VariantType;
