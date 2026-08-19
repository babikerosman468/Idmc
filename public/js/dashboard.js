
document.addEventListener("DOMContentLoaded",function(){

if(typeof Chart==="undefined"){

console.log("Chart.js not loaded");

return;

}

const ctx=document.getElementById("summaryChart");

if(!ctx)return;

new Chart(ctx,{

type:"bar",

data:{

labels:[
"Projects",
"Publications",
"Researchers",
"Diseases"
],

datasets:[{

label:"IDMC Summary",

data:[
window.dashboardStats.projects,
window.dashboardStats.publications,
window.dashboardStats.researchers,
window.dashboardStats.diseases
]

}]

},

options:{

responsive:true,

maintainAspectRatio:false

}

});

});

