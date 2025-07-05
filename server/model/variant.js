const mongoose = require('mongoose');

//individual variant 
//name-- red, XL respectively
const variantSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    variantTypeId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'variantType',
        required: true
    }
},{ timestamps: true });

module.exports = mongoose.model('variant', variantSchema);
