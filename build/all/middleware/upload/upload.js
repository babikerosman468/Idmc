
const multer=require("multer");

const path=require("path");

const storage=multer.diskStorage({

destination:function(req,file,cb){

cb(null,"uploads/documents");

},

filename:function(req,file,cb){

const filename=

Date.now()+"_"+file.originalname;

cb(null,filename);

}

});

module.exports=

multer({

storage:storage,

limits:{

fileSize:20*1024*1024

}

});

