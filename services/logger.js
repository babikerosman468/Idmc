
const fs=require("fs");

exports.write=function(message){

const now=new Date().toISOString();

fs.appendFileSync(

"logs/idmc.log",

now+" "+message+"\n"

);

}

