
const fs=require("fs");
const path=require("path");

const {getDatabase,saveDatabase}=require("./db");

async function migrate(){

const db=await getDatabase();

function exists(name){

const t=db.exec(
"SELECT name FROM sqlite_master WHERE type='table' AND name='"+name+"'"
);

return t.length>0;

}

////////////////////////////////////////////////////////////
// Researchers
////////////////////////////////////////////////////////////

if(!exists("researchers")){

db.run(`

CREATE TABLE researchers(

id INTEGER PRIMARY KEY AUTOINCREMENT,

fullname TEXT,

institution TEXT,

department TEXT,

email TEXT,

phone TEXT,

orcid TEXT,

speciality TEXT,

country TEXT,

biography TEXT,

created_at TEXT

);

`);

console.log("researchers created");

}

////////////////////////////////////////////////////////////
// Datasets
////////////////////////////////////////////////////////////

if(!exists("datasets")){

db.run(`

CREATE TABLE datasets(

id INTEGER PRIMARY KEY AUTOINCREMENT,

title TEXT,

description TEXT,

filename TEXT,

project_id INTEGER,

uploaded_at TEXT

);

`);

console.log("datasets created");

}

////////////////////////////////////////////////////////////
// Diseases
////////////////////////////////////////////////////////////

if(!exists("diseases")){

db.run(`

CREATE TABLE diseases(

id INTEGER PRIMARY KEY AUTOINCREMENT,

name TEXT,

category TEXT,

description TEXT,

symptoms TEXT,

transmission TEXT,

prevention TEXT

);

`);

console.log("diseases created");

}

////////////////////////////////////////////////////////////
// Training
////////////////////////////////////////////////////////////

if(!exists("courses")){

db.run(`

CREATE TABLE courses(

id INTEGER PRIMARY KEY AUTOINCREMENT,

title TEXT,

description TEXT,

instructor TEXT,

duration TEXT,

level TEXT

);

`);

console.log("courses created");

}

////////////////////////////////////////////////////////////
// Seed Diseases
////////////////////////////////////////////////////////////

const c=db.exec(
"SELECT COUNT(*) FROM diseases"
);

if(c[0].values[0][0]==0){

db.run("INSERT INTO diseases(name,category) VALUES('Malaria','Parasitic')");
db.run("INSERT INTO diseases(name,category) VALUES('Dengue','Viral')");
db.run("INSERT INTO diseases(name,category) VALUES('Tuberculosis','Bacterial')");
db.run("INSERT INTO diseases(name,category) VALUES('Cholera','Bacterial')");
db.run("INSERT INTO diseases(name,category) VALUES('COVID-19','Viral')");
db.run("INSERT INTO diseases(name,category) VALUES('Influenza','Viral')");
db.run("INSERT INTO diseases(name,category) VALUES('Mpox','Viral')");
db.run("INSERT INTO diseases(name,category) VALUES('Ebola','Viral')");

console.log("Sample diseases inserted");

}

saveDatabase(db);

console.log("");
console.log("Migration completed.");

}

migrate();

