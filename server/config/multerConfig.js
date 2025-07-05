const multer = require("multer");
const crypto= require("crypto");
const path=require("path");

const storageCategory= multer.diskStorage({
    destination:(req,file,cb)=>{
        cb(null,path.join(__dirname, "../public/category"));
    },
    filename:(req,file,cb)=>{
        crypto.randomBytes(12,(err,bytes)=>{
            const fileType=[".jpeg", ".jpg", ".png"];
            const extname=path.extname(file.originalname).toLowerCase();
            const fn=bytes.toString("hex")+extname;
            if(fileType.includes(extname)){
                cb(null,fn);
            }else{
                cb(new Error("Only jpeg, png, jpg filetype allowed"));
            }
        })
    }
})

const uploadCategory = multer({
  storage: storageCategory,
  limits: {
    fileSize: 1024 * 1024 * 5 // limit filesize to 5MB
  },
});

const storagePoster= multer.diskStorage({
    destination:(req,file,cb)=>{
        cb(null,path.join(__dirname, "../public/posters"));
    },
    filename:(req,file,cb)=>{
        crypto.randomBytes(12,(err,bytes)=>{
            if (err) return cb(err);
            const fileType=[".jpeg", ".jpg", ".png"];
            const extname=path.extname(file.originalname).toLowerCase();
            const fn=bytes.toString("hex")+extname;
            if(fileType.includes(extname)){
                cb(null,fn);
            }else{
                cb(new Error("Only jpeg, png, jpg filetype allowed"));
            }
        })
    }
})

const uploadPoster = multer({
  storage: storagePoster,
  limits: {
    fileSize: 1024 * 1024 * 5 
  },
});

const storageProduct= multer.diskStorage({
    destination:(req,file,cb)=>{
        cb(null,path.join(__dirname, "../public/products"));
    },
    filename:(req,file,cb)=>{
        crypto.randomBytes(12,(err,bytes)=>{
            const fileType=[".jpeg", ".jpg", ".png"];
            const extname=path.extname(file.originalname).toLowerCase();
            const fn=bytes.toString("hex")+extname;
            if(fileType.includes(extname)){
                cb(null,fn);
            }else{
                cb(new Error("Only jpeg, png, jpg filetype allowed"));
            }
        })
    }
})

const uploadProduct = multer({
  storage: storageProduct,
  limits: {
    fileSize: 1024 * 1024 * 5 
  },
});

module.exports = {
    uploadCategory,
    uploadProduct,
    uploadPoster,
};
