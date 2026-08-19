
const express=require("express");

const router=express.Router();

const controller=

require("../controllers/SearchController");

router.get("/",controller.search);

module.exports=router;

