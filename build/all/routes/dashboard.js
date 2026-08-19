
const express=require("express");

const router=express.Router();

const {getDatabase}=require("../database/db");

const dashboard=require("../services/dashboard");

router.get("/",async(req,res)=>{

const db=await getDatabase();

const stats=
dashboard.statistics(db);

res.render("dashboard",{

stats

});

});

module.exports=router;

