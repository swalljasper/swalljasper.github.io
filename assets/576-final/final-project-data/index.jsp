<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset='utf-8' />
    <title></title>
    <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
    <script src='https://api.tiles.mapbox.com/mapbox-gl-js/v0.34.0/mapbox-gl.js'></script>
    <link href='https://api.tiles.mapbox.com/mapbox-gl-js/v0.34.0/mapbox-gl.css' rel='stylesheet' />
    <style>
        body { margin:0; padding:0; }
        #map { position:absolute; top:0; bottom:0; width:100%; }
    </style>
</head>
<body>
<style>
    h2{
        -webkit-text-fill-color: white;
        font-size: 20px;
    }
    h3{
        position: absolute;
        z-index: 3500;
        top: -3px;
        left: 16%;
    }
    h4{
        position: absolute;
        z-index: 4500;
        top: -30px;
        font-size: 20px;  
    }
    h5{
        font-size: 20px;
        color: #fff;
        z-index: 4500;
    }
    p.descriptionText{
        font-size: 17px;
        display: inline;
    }
    p.decriptionText:focus{
        outline: none;
        border: none;
    }
    .mapButton{
    height: 55px;
    width: 55px;
    position: absolute;
    z-index: 1000;
    background-color: #303030;
    border-radius: 4px;
    box-shadow: 0px 0px 5px 3px #999999;
    }
    .mapButton:hover{
    background-color: #000;
    }
   #options {
    top: 8px;
    right: 8px;
   }
   #fileReportButton{
    top: 71px;
    right: 8px;
   } 
   .outer {
    height: 65%;
    width: 100%;
    position: absolute;
    z-index: 1500;
    bottom: 0;
    background-color: #333;
    box-shadow: 0px 0px 8px 3px #6b6b6b;
   }
   #filtersPanel {
    height: 98%;
    width: 98%;
    position: absolute;
    top: 1%;
    left: 1%;
    z-index: 1500;
    bottom: 0;
    background-color: #333;
    overflow: scroll;
   }
   #reportPanel {
    height: 98%;
    width: 98%;
    position: absolute;
    top: 1%;
    left: 1%;
    z-index: 1500;
    bottom: 0;
    background-color: #333;
    overflow: scroll;
   }
   #typeTitle{
    height: 60px;
    width: 100%;
    position: absolute;
    z-index: 2000;
    padding-left: 7%;
    background-color: #000;
   }
   #reportTitle{
    height: 60px;
    width: 100%;
    position: absolute;
    z-index: 2000;
    padding-left: 7%;
    background-color: #000;
   }
   .typeFilterButton {
    height: 50px;
    width: 100%;
    position: absolute;
    z-index: 2000;
    background-color: #92BDBA;
    padding-left: 4%;
    display: inline;
    box-shadow: 0px 0px 3px 2px #232323;
   }
   .typeFilterButton:hover{
    background-color: #3AA6F1;
   }
   #unsafeEnvironmentsCrimes{
    top:60px;
   }
   #sexualCrimes{
    top:115px;
   }
   #theftCrimes{
    top:170px;
   }
   #harmfulCrimes{
    top:225px;
   }
   #otherCrimes{
    top:280px;
   }
   .typeReportButton {
    height: 50px;
    width: 100%;
    position: absolute;
    z-index: 2000;
    background-color: #356A66;
    padding-left: 4%;
    display: inline;
    box-shadow: 0px 0px 3px 2px #232323;
   }
   .typeReportButton:hover{
    background-color: #3AA6F1;
   }
   #unsafeEnvironmentsCrimes-report{
    top:60px;
   }
   #sexualCrimes-report{
    top:115px;
   }
   #theftCrimes-report{
    top:170px;
   }
   #harmfulCrimes-report{
    top:225px;
   }
   #otherCrimes-report{
    top:280px;
   }
   input {
    background-color: transparent;
    display: inline-block;
    position: absolute;
    width: 80%;
    left: 10%;
    }
    #timeSwitch{
    height: 50px;
    width: 100%;
    position: absolute;
    z-index: 2000;
    background-color: #356A66;
    top: 345px; 
    padding-left: 4%; 
    }
    #sliderContainer{
    height: 60px;
    width: 100%;
    position: absolute;
    z-index: 2500;
    background-color: ;
    top: 405px;
    background-color: #444;
    }
    #sliderIndicator{
    height: 30px;
    width: 40%;
    position: absolute;
    z-index: 4000;
    bottom: 0px;
    left: 30%;
    text-align: center;
    }
    #goButton{
    height: 60px;
    width: 30%;
    position: absolute;
    z-index: 2500;
    background-color: #3AA6F1;
    top: 480px;
    left:35%;
    margin-bottom: 12px;
    text-align: center;
   }
   #reportGoButton{
    height: 60px;
    width: 30%;
    position: absolute;
    z-index: 2500;
    background-color: #3AA6F1;
    top: 480px;
    left:35%;
    margin-bottom: 12px;
    text-align: center;
   }
   #selectGeometryButton{
    height: 80px;
    width: 30%;
    position: absolute;
    z-index: 2500;
    background-color: #3AA6F1;
    bottom: 20px;
    left:35%;
    text-align: center;
    border-radius: 4px;
   }
   #description{
    height: 100px;
    width: 98%;
    position: absolute;
    z-index: 2000;
    top: 345px;
    left: 1%;
    background-color: #4c4c4c;
    box-shadow: 0px 0px 5px 1px #000;
    padding: 10px;
   }
   .svg{
    max-height: 50px;
    max-width: 50px;
   }
   .reportSvg{
    max-height: 50px;
    max-width: 50px;
   }
   #centerIcon{
    position: absolute;
    height: 4%;
    width: 4%;
    top: 48%;
    left: 48%;
   }
   #Xout{
    position: absolute;
    height: 40px;
    width: 40px;
    top: 8px;
    left: 8px;
    border-radius: 4px;
    background-color: #000;
    opacity: 0.4;
   }
   #escapeX{
    max-height: 40px;
    max-width: 40px;
   }
   /*http://jqueryui.com/slider/#range*/

</style>

<div id='map'></div>
<pre id='coordinates' class='coordinates'></pre>
<div class='mapButton'id='options'><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
     viewBox="0 0 55 55" enable-background="new 0 0 55 55" xml:space="preserve">
<line fill="none" stroke="#FFFFFF" stroke-width="4" stroke-miterlimit="10" x1="3" y1="16" x2="51" y2="16"/>
<line fill="none" stroke="#FFFFFF" stroke-width="4" stroke-miterlimit="10" x1="3" y1="28" x2="51" y2="28"/>
<line fill="none" stroke="#FFFFFF" stroke-width="4" stroke-miterlimit="10" x1="3" y1="40" x2="51" y2="40"/>
<circle stroke="#FFFFFF" stroke-width="4" stroke-miterlimit="10" cx="18.4" cy="15.9" r="5.6"/>
<circle stroke="#FFFFFF" stroke-width="4" stroke-miterlimit="10" cx="36.4" cy="39.9" r="5.6"/>
</svg></div>
<div class='mapButton'id='fileReportButton'><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
     viewBox="0 0 55 55" enable-background="new 0 0 55 55" xml:space="preserve">
<path fill="none" stroke="#FFFFFF" stroke-width="4" stroke-linecap="square" stroke-miterlimit="10" d="M4,27.5
    c11.8-16.2,34.6-17.1,46,0 M4,27c11.8,16.2,34.6,17.1,46,0"/>
<circle fill="#FFFFFF" cx="27.7" cy="27" r="11.3"/>
<text transform="matrix(1 0 0 1 23.1667 35.875)" font-family="'Futura-CondensedExtraBold'" font-size="20">!</text>
</svg></div>

<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- <script src="secondaryMap.js"></script> -->
<script>
//TESTING ZONE
console.log("running1")

//

var filterGroup = document.getElementById('filter-group');

var unsafeEnvironmentsCrimes = ["CRIMINAL DAMAGE","MOTOR VEHICLE THEFT","WEAPONS VIOLATION","INTERFERENCE WITH PUBLIC OFFICER","PUBLIC PEACE VIOLATION","CRIMINAL TRESPASS","BURGLARY","NARCOTICS","ARSON","STALKING","PROSTITUTION","OBSCENITY","PUBLIC INDECENCY","ADDED UNSAFE ENVIRONMENTS"]
var otherCrimes = ["OFFENSE INVOLVING CHILDREN","DECEPTIVE PRACTICE","OTHER OFFENSE","CONCEALED CARRY LICENSE VIOLATION","NON-CRIMINAL","LIQUOR LAW VIOLATION","GAMBLING","NON-CRIMINAL (SUBJECT SPECIFIED)","HUMAN TRAFFICKING","ADDED OTHER"]
var sexualCrimes = ["CRIM SEXUAL ASSAULT","SEX OFFENSE","ADDED SEXUAL"]
var theftCrimes = ["THEFT","ADDED THEFT"]
var harmfulCrimes = ["BATTERY","ROBBERY","ASSAULT","HOMICIDE","KIDNAPPING","INTIMIDATION", "ADDED HARMFUL CRIMES"]
var allCrimesArray = [unsafeEnvironmentsCrimes,sexualCrimes,theftCrimes,harmfulCrimes,otherCrimes]
var crimeTypeKeys = ["UNSAFE ENVIRONMENTS","SEXUAL","THEFT","HARMFUL / PERSONAL","OTHER"]
var crimeTypeLabels = ["Unsafe Environments","Sexual Crimes","Theft","Harmful or Personal Crimes", "Other Crimes"]
var crimeDivIDs = ["unsafeEnvironmentsCrimes","sexualCrimes","theftCrimes","harmfulCrimes","otherCrimes"]
var addedCrimesKey = {"unsafeEnvironmentsCrimes-report":"ADDED UNSAFE ENVIRONMENTS","sexualCrimes-report":"ADDED SEXUAL","theftCrimes-report":"ADDED THEFT","harmfulCrimes-report":"ADDED HARMFUL CRIMES","otherCrimes-report":"ADDED OTHER"}

var rangeSlider = "<div data-role='rangeslider'><label for='range-1a'>Rangeslider:</label><input name='range-1a' id='range-1a' min='0' max='24' value='0' type='range' /><label for='range-1b'>Rangeslider:</label><input name='range-1b' id='range-1b' min='0' max='100' value='100' type='range' /></div>"
//https://api.jquerymobile.com/rangeslider/

var globalFilters = []
var layers = {}
var filtersAlreadyCreated = false
var reportPanelCreated = false
var filterPanelOn = false
var reportPanelOn = false
var setLocationOn = false

var timeFilterEngaged = false
var reportedCrime = {"type":"Feature","geometry":{"type":"Point","coordinates":[null,null]},"properties":{"ID":null,"Case Numbe":"","Date":"","Block":"","IUCR":"","Primary Ty":"","Descriptio":"","Location D":"","Arrest":"","Domestic":"","Beat":null,"District":null,"Ward":null,"Community":null,"FBI Code":"","X Coordina":null,"Y Coordina":null,"Year":null,"Updated On":"","Latitude":null,"Longitude":null,"Location":""}}


var svgChecked1 = "<svg version='1.1' class='svg' id='svgChecked-"
var svgChecked2 = "' x='0px' y='0px' viewBox='0 0 50 50' enable-background='new 0 0 50 50' xml:space='preserve'><circle fill='none' stroke='#000000' stroke-width='2' stroke-miterlimit='10' cx='25.5' cy='25.5' r='12.5'/><circle cx='25.5' cy='25.5' r='10'/></svg>"
var svgUnchecked1 = "<svg version='1.1' class='svg' id='svgUnchecked-"
var svgUnchecked2 = "' x='0px' y='0px' viewBox='0 0 50 50' enable-background='new 0 0 50 50' xml:space='preserve'><circle fill='none' stroke='#000000' stroke-width='2' stroke-miterlimit='10' cx='25.5' cy='25.5' r='12.5'/></svg>"

var svgChecked1Report = "<svg version='1.1' class='reportSvg' id='svgChecked-"
var svgChecked2Report = "' x='0px' y='0px' viewBox='0 0 50 50' enable-background='new 0 0 50 50' xml:space='preserve'><circle fill='none' stroke='#000000' stroke-width='2' stroke-miterlimit='10' cx='25.5' cy='25.5' r='12.5'/><circle cx='25.5' cy='25.5' r='10'/></svg>"
var svgUnchecked1Report = "<svg version='1.1' class='reportSvg' id='svgUnchecked-"
var svgUnchecked2Report = "' x='0px' y='0px' viewBox='0 0 50 50' enable-background='new 0 0 50 50' xml:space='preserve'><circle fill='none' stroke='#000000' stroke-width='2' stroke-miterlimit='10' cx='25.5' cy='25.5' r='12.5'/></svg>"

var centerIcon = '<svg version="1.1" id="centerIcon" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 25 25" enable-background="new 0 0 25 25" xml:space="preserve"><circle opacity="0.65" fill="#303ED9" cx="12" cy="12" r="12.5"/><circle cx="11.5" cy="11.5" r="2"/></svg>'

var escapeX = '<svg version="1.1" id="escapeX" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 40 40" enable-background="new 0 0 40 40" xml:space="preserve"><line fill="none" stroke="#424242" stroke-width="8" stroke-linecap="round" stroke-miterlimit="10" x1="6.1" y1="5.3" x2="34.8" y2="33.8"/><line fill="none" stroke="#424242" stroke-width="8" stroke-linecap="round" stroke-miterlimit="10" x1="34.8" y1="5.3" x2="6.1" y2="33.8"/></svg>'

//global filters object

mapboxgl.accessToken = 'pk.eyJ1Ijoic3dhbDk0IiwiYSI6ImNpZnk5aWdzcDR5dDl0ZWx5dDhwZW13ejAifQ.y18LYK4VbBo8evRHtqiEiw';
var map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/light-v9',
    center: [-87.6583735, 41.8814659],
    zoom: 12
});

map.on('load', function () {
    getUrbanData(map)
});

function getUrbanData(map) {

    $.ajax({
        url: "HttpServlet",
        type: "POST",
        data: {"action":"recieve"}, //actions are recieve and send
        success: function(data){
        	
        	//var results  = Json.parse(data);
	
            organizeData(data)

        },
        error: function(xhr, status, error){
            console.log("An AJAX error occured: " + status);
            console.log(xhr);
            console.log("Error: " + error)
        }   

    });

}

$("#options").click(function(){
    if (filtersAlreadyCreated && !filterPanelOn && !reportPanelOn && !setLocationOn){
        filterPanelOn = true
        $("#outterFiltersPanel").css("visibility","visible")
    } else if (filtersAlreadyCreated && filterPanelOn){
        filterPanelOn = false
        $("#outterFiltersPanel").css("visibility","hidden")
    } else if(!reportPanelOn && !setLocationOn) {
        filtersAlreadyCreated = true
        filterPanelOn = true
        createFilters()
    }

})

$("#fileReportButton").click(function(){
    if (!filterPanelOn && !reportPanelOn && !setLocationOn){
        setLocationOn = true
        selectGeometryMode(map)
        $("body").append($("<div id='Xout'>" + escapeX + "</div>"))
        $("#Xout").click(function(){
            $("#selectGeometryButton").remove()
            $("#centerIcon").remove()
            setLocationOn = false
            $(this).remove()
            $("#outterReportPanel").remove()
            reportPanelOn = false
        }) 
    }
    
    //createReportPanel()
})

function organizeData(data){
	
	//var data = JSON.parse(result);
 
	console.log(data)
	


            for (i in data.features){
            	
            	
            	var feature = data.features[i];
            	
            	console.log(feature.properties);
            	
            	//var obj = JSON.parse(feature.properties);
     
            	
            	
            	
             	console.log(feature.properties['Primary Ty']);
            
                var incomingTime = feature.properties['Date']
                
               	
                console.log(incomingTime);

                var time = incomingTime.slice(11,13)

                time = parseInt(time)

                if (incomingTime.slice(20) == 'PM') {
                    var isAfternoon = true
                } else {
                    var isAfternoon = false
                }

                if (time == 12 && !isAfternoon){time = 0}

                if (isAfternoon && time != 12){time += 12}

                if (time == 24){console.log("!!!!!!")}

                data.features[i].properties['Date'] = time


            }


            
            map.addSource('crimes', {
                'type': 'geojson',
                'data': data
            });

            data.features.forEach(function(feature){
            	
            	

                var incomingType = feature.properties['Primary Ty']
               
                var filterBase = ['in', 'Primary Ty']

                for (i in allCrimesArray) {
                    if (allCrimesArray[i].indexOf(incomingType) != -1){
                        if (i == 0){type = "UNSAFE ENVIRONMENTS"}
                        if (i == 1){type = "OTHER"} 
                        if (i == 2){type = "SEXUAL"}
                        if (i == 3){type = "THEFT"}
                        if (i == 4){type = "HARMFUL / PERSONAL"}

                        var typeFilter = filterBase.concat(allCrimesArray[i])
                    }
                }

                var layerID = type + '-' + feature.properties['Date'] + '_layer';


                if (!map.getLayer(layerID)){

                    var element = {layer:layerID, typeFilter: true, timeFilter: true}
                    globalFilters.push(element)

                    layers[layerID] = true

                    map.addLayer({
                        'id': layerID,
                        'type': 'circle',
                        'source': 'crimes',
                        'layout': {
                            'visibility': 'visible'
                        },
                        'paint': {
                            'circle-radius': 2,
                            'circle-color': 'rgba(153, 0, 0, 0.8)'
                        },
                        "filter": ["all",typeFilter,["==","Date",feature.properties['Date']]]
                    });

                }
            });
}

function createFilters(){

    $("body").append($("<div class='outer' id='outterFiltersPanel'></div>"))
    $("#outterFiltersPanel").append($("<div id='filtersPanel'></div>"))
    $("#outterFiltersPanel").append($("<div class='filtersTitle' id='typeTitle'><h2>Filter Crime By Type and Time of Day</h2></div>"))
    $("#filtersPanel").append($("<div id='goButton'><h2>APPLY</h2></div>"))
    $("#filtersPanel").append($("<div id='timeSwitch'>" + svgUnchecked1 + "time" + svgUnchecked2 + "<h3>Filter Crime By Time</h3></div>"))
    $("#goButton").click(function(){
        changeMapVisibility()
        $("#outterFiltersPanel").css("visibility","hidden")
        filterPanelOn = false
    })
    $("#timeSwitch").click(function(){
        switchTimeFilter($(this))
    })
    for (i in crimeTypeKeys){
        $("#filtersPanel").append($("<div class='typeFilterButton' id='" + i + "'>" + svgChecked1 + crimeDivIDs[i] + svgChecked2 + "<h3>" + crimeTypeLabels[i] + "</h3></div>"))
        $("#" + i).attr('id', crimeDivIDs[i])
        $("#"+crimeDivIDs[i]).click(function(){
            if (!($(this).hasClass("turnedOff"))){
                $(this).addClass("turnedOff")
                $(this).css("background-color","#356A66")
                //$(".typeFilterButton:hover").css("background-color", "#3AA6F1")
                changeTypeFilters($(this).attr("id"), true)
                $("#svgChecked-" + $(this).attr("id")).remove()
                $(this).append($(svgUnchecked1 + $(this).attr("id") + svgUnchecked2))
                $(this).hover(function(){
                    $(this).css("background-color", "#418091")
                    }, function(){
                    $(this).css("background-color", "#356A66")
                })
            } else {
                $(this).removeClass("turnedOff")
                $(this).css("background-color","#92BDBA")
                //$(".typeFilterButton:hover").css("background-color", "#3AA6F1")
                changeTypeFilters($(this).attr("id"), false)
                $("#svgUnchecked-" + $(this).attr("id")).remove()
                $(this).append($(svgChecked1 + $(this).attr("id") + svgChecked2))
                $(this).hover(function(){
                    $(this).css("background-color", "#3AA6F1")
                    }, function(){
                    $(this).css("background-color", "#92BDBA")
                })
            } 

        })
    }
}

function createReportPanel(){
    reportPanelOn = true
    $("body").append($("<div class='outer' id='outterReportPanel'></div>"))
    $("#outterReportPanel").append($("<div id='reportPanel'></div>"))
    $("#outterReportPanel").append($("<div class='filtersTitle' id='typeTitle'><h2>Report Suspicious Activity</h2></div>"))
    for (i in crimeTypeKeys){
        $("#reportPanel").append($("<div class='typeReportButton' id='" + i + "'>" + svgUnchecked1Report + crimeDivIDs[i] + svgUnchecked2Report + "<h3>" + crimeTypeLabels[i] + "</h3></div>"))
        $("#" + i).attr('id', crimeDivIDs[i] + "-report")
        $("#"+crimeDivIDs[i] + "-report").click(function(){
            var id = $(this).attr("id")
            $(".reportSvg").remove()
            $(this).append($(svgChecked1Report + id + svgChecked2Report))
            $(this).css("background-color","#92BDBA")
            for (j in crimeTypeKeys){
                if ($(this).attr("id") != crimeDivIDs[j] + "-report"){
                    console.log(j)
                    $("#" + crimeDivIDs[j] + "-report").append(svgUnchecked1Report + crimeDivIDs[j] + svgUnchecked2Report)
                    $("#" + crimeDivIDs[j] + "-report").css("background-color","#356A66")
                    $("#" + crimeDivIDs[j] + "-report").hover(function(){
                        $(this).css("background-color", "#3AA6F1")
                        }, function(){
                        $(this).css("background-color", "#356A66")
                    })
                }
            }
            $(this).hover(function(){
                $(this).css("background-color", "#92BDBA")
            }, function(){
                $(this).css("background-color", "#92BDBA")
            })
            reportedCrime.properties["Primary Ty"] = addedCrimesKey[$(this).attr("id")]

        })
    }
    $("#reportPanel").append($("<div id='description'><p contenteditable='true' id='descriptionText'>Enter Description</p></div>"))
    $("#descriptionText").click(function(){
        console.log("ran")
        document.getElementById("descriptionText").innerHTML = ""
    })
    $("#reportPanel").append($("<div id='reportGoButton'><h2>Submit</h2></div>"))
    $("#reportGoButton").click(function(){
        reportPanelOn = false
        $("#Xout").remove()
        submitReport()
    })
}

function changeTypeFilters(id,turnOff){
    if (id == "unsafeEnvironmentsCrimes"){
       filterKeyword = "UNSAFE ENVIRONMENTS"; 
    } else if (id == "sexualCrimes"){
       filterKeyword = "SEXUAL"; 
    } else if (id == "theftCrimes"){
       filterKeyword = "THEFT"; 
    } else if (id == "harmfulCrimes"){
       filterKeyword = "HARMFUL / PERSONAL"; 
    } else if (id == "otherCrimes"){
       filterKeyword = "OTHER"; 
    }

    //relic, changes old single object
    for (key in layers){
        if (key.includes(filterKeyword) && turnOff){
            layers[key] = false
        } else if (key.includes(filterKeyword) && !turnOff) {
            layers[key] = true
        }
    }

    for (i in globalFilters){
        if (globalFilters[i]['layer'].includes(filterKeyword) && turnOff){
            globalFilters[i]['typeFilter'] = false
        } else if (globalFilters[i]['layer'].includes(filterKeyword) && !turnOff){
            globalFilters[i]['typeFilter'] = true
        }
    }

}

function changeMapVisibility(){
    console.log(layers)
    // for (key in layers){
    //     if (layers[key]){
    //         map.setLayoutProperty(key, 'visibility', 'visible');
    //     } else {
    //         map.setLayoutProperty(key, 'visibility', 'none');
    //     }

    // }

    for (i in globalFilters){
        if (globalFilters[i]['typeFilter'] && globalFilters[i]['timeFilter']){
            map.setLayoutProperty(globalFilters[i]['layer'], 'visibility', 'visible');
        } else {
            map.setLayoutProperty(globalFilters[i]['layer'], 'visibility', 'none');
        }
    }
}

function switchTimeFilter(div){
    if (timeFilterEngaged == false){
        timeFilterEngaged = true
        div.css("background-color","#92BDBA")
        $("#svgUnchecked-time").remove()
        div.append($(svgChecked1 + "time" + svgChecked2))
        $("#filtersPanel").append($("<div id='sliderContainer'><input id='slider' type='range' min='0' max='23' step='1' value='0' /></div>"))
        utilizeSlider();
    } else {
        timeFilterEngaged = false
        $("#svgChecked-time").remove()
        div.append($(svgUnchecked1 + "time" + svgUnchecked2))
        div.css("background-color","#356A66")
        $("#sliderContainer").remove()
        filterForSlider()
    }
}

function utilizeSlider(){
    changeSliderFeedback(0)
    filterForSlider(0)

    document.getElementById('slider').addEventListener('input', function(e) {
        var sliderValue = e.target.value
        console.log(sliderValue)
        changeSliderFeedback(sliderValue)

        filterForSlider(sliderValue)

    });
}

function filterForSlider(sliderValue){

    var stringSliderValue = String(sliderValue)
    stringSliderValue += "_"

        if (timeFilterEngaged){    
            for (i in globalFilters){
                if (globalFilters[i]['layer'].includes(stringSliderValue)){
                    globalFilters[i]['timeFilter'] = true
                } else {
                    globalFilters[i]['timeFilter'] = false
                }
            }
        } else {
            for (i in globalFilters){
               globalFilters[i]['timeFilter'] = true 
            }
        }
}

function changeSliderFeedback(sliderInput){

    $("#sliderIndicator").remove()

    if (sliderInput > 12){
        sliderInput -= 12
        var AMorPM = "PM"
    } else {
        var AMorPM = "AM"
    }

    if (sliderInput == 12){
        var nextHour = 1
        if (AMorPM == "AM"){
            nextHour += " PM"
        } else {
            nextHour += " AM"
        }
    } else if (sliderInput == 11 && AMorPM == "PM"){
        nextHour = "12 AM"
    } else {
        sliderInput = parseInt(sliderInput)
        var nextHour = sliderInput + 1
        nextHour += " " + AMorPM 
    }

    if (sliderInput == 12){AMorPM = "PM"}
    if (sliderInput == 0){ sliderInput = 12}

    $("#sliderContainer").append($("<div id='sliderIndicator'><h4>" + sliderInput + " " + AMorPM + " – " + nextHour + "</h4></div>"))
}

function selectGeometryMode(map){

    $("body").append($("<div id='selectGeometryButton'><h2>Select Location</h2></div>"))
    $("body").append($(centerIcon))
    $("#selectGeometryButton").click(function(){
        centerCoordinates = map.getCenter()
        reportedCrime.geometry.coordinates[0] = centerCoordinates['lng']
        reportedCrime.geometry.coordinates[1] = centerCoordinates['lat']
        createReportPanel()
        $(this).remove()
        $("#centerIcon").remove()
        setLocationOn = false 
    })
}

function submitReport(){
    var desText = document.getElementById("descriptionText").innerHTML
    reportedCrime.properties.Descriptio = desText

    var currentDate = timeStamp()
    reportedCrime.properties["Date"] = currentDate

    var typeReported = reportedCrime.properties["Primary Ty"]
    var lon = reportedCrime.geometry.coordinates[0]
    var lat = reportedCrime.geometry.coordinates[1]

    var dataToSend = {"action":"send","Date":currentDate,"Description":desText,"Type":typeReported,"lat":lat,"lon":lon}

    $.ajax({
        url: "HttpServlet",
        type: "POST",
        data: dataToSend,
        success: function(report){
        	console.log("success")
        	alert("Report Submitted")
            //reload data to page
            //feedback about report submission
            //reset form
        },
        error: function(xhr, status, error){
            console.log("Status: " + status)
            console.log("Error: " + error)
        }
    });


    //send to server here
    $("#outterReportPanel").remove()
}

function timeStamp() {
// Create a date object with the current time
  var now = new Date();

// Create an array with the current month, day and time
  var date = [ now.getMonth() + 1, now.getDate(), now.getFullYear() ];

  for (i in date){
    date[i] = String(date[i])
    if (date[i].length == 1){ date[i] = "0" + date[i]}
  }

// Create an array with the current hour, minute and second
  var time = [ now.getHours(), now.getMinutes(), now.getSeconds() ];

// Determine AM or PM suffix based on the hour
  var suffix = ( time[0] < 12 ) ? "AM" : "PM";

// Convert hour from military time
  time[0] = ( time[0] < 12 ) ? time[0] : time[0] - 12;
  time[0] = String(time[0])
  if (time[0].length == 1){ time[0] = "0" + time[0]}

// If hour is 0, set it to 12
  time[0] = time[0] || 12;

// If seconds and minutes are less than 10, add a zero
  for ( var i = 1; i < 3; i++ ) {
    if ( time[i] < 10 ) {
      time[i] = "0" + time[i];
    }
  }

// Return the formatted string
  return date.join("/") + " " + time.join(":") + " " + suffix;
}



</script>




</body>
</html>