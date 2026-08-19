
const express=require("express");

const router=express.Router();

const system=require("../services/system");

router.get("/",(req,res)=>{

res.json(system.info());

});

module.exports=router;

