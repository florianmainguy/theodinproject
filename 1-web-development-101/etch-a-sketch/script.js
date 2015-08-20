$(document).ready(function(){
    $("body").append("<h1>Etch A Sketch</h1>");
    $("body").append("<div class=header></div>");
    $(".header").append("<button id='clear'>Clear</button>");
    $(".header").append("<button id='resize'>Resize</button>");
    $("body").append("<div class=container></div>");
    
    { generateGrid('16'); }
    
    $("#resize").click(function(){
        numSquare = prompt("How many squares per side?");
        { generateGrid(numSquare); }
    });
    $("#clear").click(function(){
        $("div>div").css("background-color","#E3E3E3");
    });
});

function generateGrid(numSquare) {
    sizeSquare = 640/numSquare - 2;
    $("div>div").remove();
    for(i=0;i<numSquare*numSquare;i++) {
        $(".container").append('<div></div>');
    };
    $("div>div").css('height', sizeSquare + "px");
    $("div>div").css('width', sizeSquare + "px");
    $("div>div").mouseenter(function(){
        $(this).css("background-color","#202020");
    });
};
