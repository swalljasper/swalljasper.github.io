var viewHeight = $(window).height() - 50

console.log(viewHeight)
$("#full").css("height",viewHeight + "px")

backgroundArray = ["turkeyJT","midEastJT","superiorJT","antarcticaJT","kilimanjaroJT","laCondesaJT"]

initBkgArrayValue = Math.floor(Math.random() * 5);
$("#full").css("background-image","url('assets/" + backgroundArray[initBkgArrayValue] + ".png')")

var bkgArrayValue = Math.floor(Math.random() * 5);
setInterval(function(){
	bkgArrayRemainder = bkgArrayValue % 6
	$("#full").css("background-image","url('assets/" + backgroundArray[bkgArrayRemainder] + ".png')")
	bkgArrayValue += 1
}, 4000)