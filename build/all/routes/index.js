
module.exports=function(app){

app.use("/dashboard",require("./dashboard"));

app.use("/projects",require("./projects"));

app.use("/publications",require("./publications"));

app.use("/researchers",require("./researchers"));

app.use("/search",require("./search"));

app.use("/uploads",require("./uploads"));

};

