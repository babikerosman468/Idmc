
const express=require("express");

const router=express.Router();
const auth=require("../middleware/auth");

const controller=require("../controllers/ResearcherController");

router.get("/",controller.list);

router.get("/add",auth,controller.addForm);

router.post("/add",auth,controller.add);

module.exports=router;

