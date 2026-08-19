const express=require("express");

const router=express.Router();

router.get("/",(req,res)=>{

res.send("bioinformatics module ready");

});

module.exports=router;
