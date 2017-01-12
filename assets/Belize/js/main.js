//Main.js
console.log('running')

mapboxgl.accessToken = 'pk.eyJ1Ijoic3dhbDk0IiwiYSI6ImNpZnk5aWdzcDR5dDl0ZWx5dDhwZW13ejAifQ.y18LYK4VbBo8evRHtqiEiw';

var mapStyle = {
    "version": 8,
    "name": "Dark",
    "sources": {
        "mapbox": {
            "type": "vector",
            "url": "mapbox://styles/swal94/ciwy0bc1g000t2qsdfd1k5at9"
        },
        "overlay": {
            "type": "image",
            "url": "../assets/SCALE1AI-01.TIF",
            "coordinates": [
                [-89.258228, 18.497686],
                [-87.750761, 18.497659],
                [-89.258277, 15.885424],
                [-87.750810, 15.885398]
            ]
        }
    },
    "sprite": "mapbox://sprites/mapbox/dark-v9",
    "glyphs": "mapbox://fonts/mapbox/{fontstack}/{range}.pbf",
    "layers": []
};

var bounds = [
    [-89.258277, 15.885424],
    [-87.750761, 18.497659]
]



layerTimeArray = ["Deforested 1980-1989", "Deforested 1989-1994", "Deforested 1994-2000", "Deforested 2000-2004", "Deforested 2004-2010" ]
layerReasonArray = ["logging0", "ag0", "urban0"]

layerArray = [[layerReasonArray[0]+layerTimeArray[0], layerReasonArray[1]+layerTimeArray[0], layerReasonArray[2]+layerTimeArray[0]],
    [layerReasonArray[0]+layerTimeArray[1], layerReasonArray[1]+layerTimeArray[1], layerReasonArray[2]+layerTimeArray[1]],
    [layerReasonArray[0]+layerTimeArray[2], layerReasonArray[1]+layerTimeArray[2], layerReasonArray[2]+layerTimeArray[2]],
    [layerReasonArray[0]+layerTimeArray[3], layerReasonArray[1]+layerTimeArray[3], layerReasonArray[2]+layerTimeArray[3]],
    [layerReasonArray[0]+layerTimeArray[4], layerReasonArray[1]+layerTimeArray[4], layerReasonArray[2]+layerTimeArray[4]]]

timelineArray = ["1980","1989","1994","2000","2004","2010"]

hiddenReasonLayers = []
hiddenTimeLayers = []



var map = new mapboxgl.Map({
    container: 'map', // container id
    style: 'mapbox://styles/swal94/ciwy0bc1g000t2qsdfd1k5at9', //stylesheet location
    center: [-88.6,17.2], // starting position
    zoom: 10, // starting zoom
    maxBounds: bounds
});

// unchecked = true
// notSlided = true

function checkBox(map) {


    if (document.getElementById('checkbox1').checked == true) {
        unchecked = false
        // if (notSlided == true) {
        //     showAndHideYear(map, 5)
        // } else {
        //     showAndHideYear(map, sliderLevel)
        // }

    } else {
        unchecked = true
    }
}

map.on('load', function() {
	getDeforestationData(map)
    getProtectedAreasData(map)
    //getAgData(map) DATA NOT WORKING
    noAgData()
    getUrbanData(map)
    checkBox(map)
    overlayDescription()
    
})




function getDeforestationData(map) {
        $.ajax("../../data/deforestation.geojson", {
        dataType: "json",
        success: function(data){

            
        loadData(map, topojson.feature(data, data.objects.def7));

        
            
        }
    });
}

function loadData(map, data){
	
	map.addSource('def', {
        'type': 'geojson',
        'data': data
    })

    organizeData(data, map)

}

function organizeData(data, map){

    var filterGroupReason = document.getElementById('reason-filter');
    var filterGroupYear = document.getElementById('year-filter');

    data.features.forEach(function(feature){

        var reason = feature.properties['reason'];
        var year = feature.properties['DESCR']
        var layerID = reason + "0" + year;

        if (!map.getLayer(layerID)) {
            map.addLayer({
                "id": layerID,
                "type": "fill",
                "source": "def",
                "layout": {
                    "visibility":"visible"
                },
                "paint": {
                    "fill-color": "#B05D5D",
                    "fill-opacity": 1
                },
                "filter": [
                    "all",
                    ["==", "reason", reason],
                    ["==", "DESCR", year]
                ]

            });


        };
        

    });


    createReasonToggle(map)
    slideTime(map)

    console.log('running')

    $("#loading").hide();
  
}



function createReasonToggle(map){




    for (var i = 0; i < layerArray[0].length; i++) {
        var idAccess = layerArray[0][i];
        var id = idAccess.split("0",1)

        

        var link = document.createElement('a');
        link.href = '#';
        link.className = 'active';
        link.textContent = id;



        link.onclick = function (e) {


            var clickedReason = this.textContent


            showAndHideReason(map, e, clickedReason, this)

    
        };

        var layers = document.getElementById('menu');
        layers.appendChild(link);
    }

}

function showAndHideReason(map, e, clickedReason, toggle){

    console.log(toggle.className)

            if (toggle.className === 'active') {
                toggle.className = 'inactive'; //be more specific-
            } else {
                toggle.className = 'active'// here too
            }

    


            for (var j = 0; j < layerArray.length; j++) {
                innerArray = layerArray[j]

                for (var k = 0; k < innerArray.length; k++) {
                    mapLayer = innerArray[k]

                    if (mapLayer.indexOf(clickedReason) > -1){

                        e.preventDefault();
                        e.stopPropagation();

                        var visibility = map.getLayoutProperty(mapLayer, 'visibility');

                        if (visibility === 'visible') {
                            map.setLayoutProperty(mapLayer, 'visibility', 'none');
                            hiddenReasonLayers.push(mapLayer)
                        } else {
                            if (hiddenTimeLayers.indexOf(mapLayer) == -1) {
                                map.setLayoutProperty(mapLayer, 'visibility', 'visible');
                            }
                            var index = hiddenReasonLayers.indexOf(mapLayer)
                            if (index > -1) {
                                hiddenReasonLayers.splice(index, 1)
                            }

                        }
                    }
                    


                }
            }


}

function slideTime(map){


    notSlided = false

    document.getElementById('slider').addEventListener('input', function(e) {

        sliderLevel = e.target.value

        adjustSliderLabel(e.target.value)

            
            if (e.target.value == 0){
                hideAllLayers(map);
            } else {
                yearFilter = e.target.value;
                if (unchecked == false) { 
                    showAndHideYear(map, yearFilter); 
                } else { 
                    showAndHideSpecificYear(map, yearFilter)
                }
            }

            
            
        });



}

function showAndHideYear(map, yearFilter) {

    hideAllLayers(map);

    var yearFilterCorrected = yearFilter - 1
    var h = yearFilterCorrected

    while (h > -1) {
        var yearArray = layerArray[h]

        for (var i = 0; i < yearArray.length; i++) {
            var mapLayer = yearArray[i]
            if (hiddenReasonLayers.indexOf(mapLayer) == -1) {
                map.setLayoutProperty(mapLayer, 'visibility', 'visible')
            }

            var index = hiddenTimeLayers.indexOf(mapLayer)
            if (index > -1) {
                hiddenTimeLayers.splice(index, 1)
            }

        }

        h--
    }

    

}

function showAndHideSpecificYear(map, yearFilter) {

    hideAllLayers(map);

    var yearFilterCorrected = yearFilter - 1
    var yearArray = layerArray[yearFilterCorrected]

    for (var i = 0; i < yearArray.length; i++) {
        var mapLayer = yearArray[i]
        
        if (hiddenReasonLayers.indexOf(mapLayer) == -1) {
            map.setLayoutProperty(mapLayer, 'visibility', 'visible')
        }

        var index = hiddenTimeLayers.indexOf(mapLayer)
        if (index > -1) {
            hiddenTimeLayers.splice(index, 1)
        }


    }

}



function hideAllLayers(map) {

    for (var i = 0; i < layerArray.length; i++) {
        innerArray = layerArray[i];

        for (var j = 0; j < innerArray.length; j++) {
            mapLayer = innerArray[j]

            map.setLayoutProperty(mapLayer, 'visibility', 'none')
            
            hiddenTimeLayers.push(mapLayer)

        }

    }
}

function adjustSliderLabel(x) {

    $('#year').remove()
    $('.map-overlay-inner').append($('<label id="year"></label>'))
    $('#year').append($('<h2>' + timelineArray[x] + '</h2>'))
}








function getAgData(map) {

    console.log('ran')

    $.ajax("../data/ag3.geojson", {
        dataType: "json",
        success: function(data){

            
        map.addSource('farm', {
            'type': 'geojson',
            'data': data
        });

        farmOff = true

        $('#agButton').click(function(){

        if (paOff == true) {

            document.getElementById('agButton').className = 'buttonActive'

            map.addLayer({
                'id': 'nowFarm',
                'type': 'fill',
                'source': 'farm',
                'layout': {
                    'visibility': 'visible'
                },
                'paint': {
                    'fill-color': '#088',
                    'fill-opacity': 0.8
                }
            }, 'logging0Deforested 1980-1989');

            farmOff = false


        } else {

            map.removeLayer('nowFarm');
            farmOff = true
            document.getElementById('agButton').className = 'overlayButton'
        }

        });

        
            
        }
    });

}





function getUrbanData(map) {

    $.ajax("../../data/Urban.geojson", {
        dataType: "json",
        success: function(data){


            
        map.addSource('city', {
            'type': 'geojson',
            'data': data
        });

        cityOff = true

        $('#urbanButton').click(function(){

        if (cityOff == true) {

            document.getElementById('urbanButton').className = 'buttonActive'

            map.addLayer({
                'id': 'nowCity',
                'type': 'fill',
                'source': 'city',
                'layout': {
                    'visibility': 'visible'
                },
                'paint': {
                    'fill-color': '#8c8c8c',
                    'fill-opacity': 0.8
                }
            }, 'logging0Deforested 1980-1989');

            cityOff = false


        } else {


            map.removeLayer('nowCity');
            cityOff = true
            document.getElementById('urbanButton').className = 'overlayButton'
        }

        });

        
            
        }
    });

}






function getProtectedAreasData(map) {


    $.ajax("../../data/ProtectedAreas1.geojson", {
        dataType: "json",
        success: function(data){


            
        map.addSource('ProtectedAreas', {
            'type': 'geojson',
            'data': data
        });

        paOff = true

        $('#paButton').click(function(){

        if (paOff == true) {

            document.getElementById('paButton').className = 'buttonActiveGreen'

            map.addLayer({
                'id': 'protectedAreas',
                'type': 'fill',
                'source': 'ProtectedAreas',
                'layout': {
                    'visibility': 'visible'
                },
                'paint': {
                    'fill-color': '#184f16',
                    'fill-opacity': 0.25
                }
            }, 'logging0Deforested 1980-1989');

            paOff = false


        } else {

            map.removeLayer('protectedAreas');
            paOff = true
            document.getElementById('paButton').className = 'overlayButton'
        }

        });

        
            
        }
    });

}

function noAgData() {

   $('#agButton').click(function(){
        window.alert("Sorry, current agriculture data isn't avaliable at this time.")
    }) 
}

function overlayDescription() {
    
    var e = document.getElementById('agButton');
    e.onmouseover = function() {
        document.getElementById('agPopup').style.display = 'block';
    }
    e.onmouseout = function() {
        document.getElementById('agPopup').style.display = 'none';
    }

    var f = document.getElementById('urbanButton');
    f.onmouseover = function() {
        document.getElementById('urbanPopup').style.display = 'block';
    }
    f.onmouseout = function() {
        document.getElementById('urbanPopup').style.display = 'none';
    }

    var g = document.getElementById('paButton');
    g.onmouseover = function() {
        document.getElementById('paPopup').style.display = 'block';
    }
    g.onmouseout = function() {
        document.getElementById('paPopup').style.display = 'none';
    }

    var h = document.getElementById('menu');
    h.onmouseover = function() {
        document.getElementById('menuPopup').style.display = 'block';
    }
    h.onmouseout = function() {
        document.getElementById('menuPopup').style.display = 'none';
    }
}


