
exports.statistics=function(db){

function count(table){

try{

const r=db.exec(
"SELECT COUNT(*) FROM "+table
);

if(r.length){

return r[0].values[0][0];

}

}catch(e){}

return 0;

}

function latest(table,column){

try{

const r=db.exec(
"SELECT "+column+" FROM "+table+
" ORDER BY id DESC LIMIT 1"
);

if(r.length && r[0].values.length){

return r[0].values[0][0];

}

}catch(e){}

return "None";

}

return{

projects:count("projects"),

publications:count("publications"),

researchers:count("researchers"),

users:count("users"),

diseases:count("diseases"),

datasets:count("datasets"),

courses:count("courses"),

latestProject:
latest("projects","title"),

latestPublication:
latest("publications","title"),

latestResearcher:
latest("researchers","fullname")

};

}

