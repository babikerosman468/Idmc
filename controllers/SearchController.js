
const {getDatabase}=require("../database/db");

exports.search=async function(req,res){

const db=await getDatabase();

const keyword=(req.query.q||"").trim();

let projects=[];
let publications=[];
let researchers=[];

if(keyword.length){

try{

let r=db.exec(

"SELECT id,title,year FROM projects WHERE title LIKE ?",

["%"+keyword+"%"]

);

if(r.length) projects=r[0].values;

}catch(e){}

try{

let r=db.exec(

"SELECT id,title FROM publications WHERE title LIKE ?",

["%"+keyword+"%"]

);

if(r.length) publications=r[0].values;

}catch(e){}

try{

let r=db.exec(

"SELECT id,fullname FROM researchers WHERE fullname LIKE ?",

["%"+keyword+"%"]

);

if(r.length) researchers=r[0].values;

}catch(e){}

}

res.render("search/index",{

keyword,

projects,

publications,

researchers

});

};

