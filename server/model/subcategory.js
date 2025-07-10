const mongoose = require('mongoose');

const subCategorySchema=mongoose.Schema({
    name:{
        type:String,
        required:true,
        trim:true
    },
    categoryId:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'category',
        required:true
    }                                                                                                                                                                                            
},
{timestamps:true}
)

const SubCategory=mongoose.model('subCategory',subCategorySchema);

module.exports = SubCategory;