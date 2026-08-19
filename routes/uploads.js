
const express=require("express");

const router=express.Router();

const upload=

require("../middleware/upload/upload");

const controller=

require("../controllers/UploadController");

router.get("/",

controller.form);

router.post("/",

upload.single("document"),

controller.upload);

module.exports=router;

