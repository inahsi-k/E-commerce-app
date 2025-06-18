const express = require('express');
const mongoose=require('mongoose');


const mUrl="mongodb+srv://ishanikarpoor02:yQAZui9YtHMybxbI@shopy.jrw4v8b.mongodb.net/?retryWrites=true&w=majority&appName=Shopy";
mongoose.connect(mUrl).then(()=>console.log("connected successfully to mongoDB")).catch((err)=>console.error(`error: ${err}`));

const PORT=3000;

const app = express();

//app.use(bodyParser.json());

app.listen(PORT,(req,res)=>console.log("Server started"));