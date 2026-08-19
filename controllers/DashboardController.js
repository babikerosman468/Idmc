
const {getDatabase}=require("../database/db");

const dashboard=require("../services/dashboard");

exports.index=async function(req,res){

const db=await getDatabase();

const stats=

dashboard.statistics(db);

res.render("dashboard",{

stats

});

}

