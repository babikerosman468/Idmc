
const express=require("express");

const router=express.Router();
const auth=require("../middleware/auth");

const upload=

require("../middleware/upload/upload");

const controller=

require("../controllers/UploadController");

router.get("/",auth,

controller.form);

router.post("/",auth,

upload.single("document"),

controller.upload);

module.exports=router;

