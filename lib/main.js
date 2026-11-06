var viewHeight = $(window).height() - 50

console.log("yo")
$("#full").css("height",viewHeight + "px")

backgroundArray = ["FakemoonJT","BakerJT","SkyIslandsJT","EverestJT","RainierJT","EverestJT"]

initBkgArrayValue = Math.floor(Math.random() * 5);
$("#full").css("background-image","url('assets/" + backgroundArray[initBkgArrayValue] + ".png')")
console.log(backgroundArray[initBkgArrayValue])

var bkgArrayValue = Math.floor(Math.random() * 5);
setInterval(function(){
	console.log("ran")
	bkgArrayRemainder = bkgArrayValue % 6
	$("#full").css("background-image","url('assets/" + backgroundArray[bkgArrayRemainder] + ".png')")
	bkgArrayValue += 1
}, 10000) 