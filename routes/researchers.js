
const express=require("express");

const router=express.Router();

const controller=require("../controllers/ResearcherController");

router.get("/",controller.list);

router.get("/add",controller.addForm);

router.post("/add",controller.add);

module.exports=router;

