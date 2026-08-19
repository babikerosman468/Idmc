
exports.form=function(req,res){

res.render("uploads/index");

};

exports.upload=function(req,res){

res.render("uploads/success",{

file:req.file

});

};

