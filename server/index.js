const express = require('express');
const mongoose=require('mongoose');
const bodyParser = require('body-parser');


const mUrl="mongodb+srv://ishanikarpoor02:yQAZui9YtHMybxbI@shopy.jrw4v8b.mongodb.net/?retryWrites=true&w=majority&appName=Shopy";
mongoose.connect(mUrl).then(()=>console.log("connected successfully to mongoDB")).catch((err)=>console.error(`error: ${err}`));

const PORT=3000;

const app = express();

app.use(bodyParser.json());

//static routes
app.use('/image/products', express.static('public/products'));
app.use('/image/category', express.static('public/category'));
app.use('/image/poster', express.static('public/posters'));

//routes
app.use('/categories', require('./routes/category'));
app.use('/subCategories', require('./routes/subcategory'));
app.use('/brands', require('./routes/brand'));

app.listen(PORT,(req,res)=>console.log("Server started"));