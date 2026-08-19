
const {getDatabase}=require("../database/db");
const {saveDatabase}=require("../database/db");

exports.list=async function(req,res){

const db=await getDatabase();

let researchers=[];

try{

const r=db.exec(
"SELECT id,fullname,institution,speciality,country FROM researchers ORDER BY fullname"
);

if(r.length){

researchers=r[0].values;

}

}catch(e){}

res.render("researchers/index",{

researchers

});

};

exports.addForm=function(req,res){

res.render("researchers/add");

};

exports.add=async function(req,res){

const db=await getDatabase();

const {

fullname,

institution,

department,

email,

phone,

orcid,

speciality,

country,

biography

}=req.body;

db.run(

`INSERT INTO researchers
(fullname,institution,department,email,phone,orcid,speciality,country,biography,created_at)
VALUES(?,?,?,?,?,?,?,?,?,datetime('now'))`,

[
fullname,
institution,
department,
email,
phone,
orcid,
speciality,
country,
biography
]

);

saveDatabase(db);

res.redirect("/researchers");

};

