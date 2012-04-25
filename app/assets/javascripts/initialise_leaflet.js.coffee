$ ->
  map = new L.Map('map')

  cloudmade = new L.TileLayer 'http://{s}.tile.cloudmade.com/3b477058df1d402fb1ea6f45611880e9/997/256/{z}/{x}/{y}.png'
    ,
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
      maxZoom: 18

  london = new L.LatLng(51.505, -0.09)
  map.setView(london, 13).addLayer(cloudmade)

  markerLocation = new L.LatLng(51.5, -0.09)

  marker = new L.Marker(markerLocation)
  map.addLayer(marker)


  circleLocation = new L.LatLng(51.508, -0.11)
  circleOptions =
    color: 'red'
    fillColor: '#f03'
    fillOpacity: 0.5

  circle = new L.Circle(circleLocation, 500, circleOptions)
  map.addLayer(circle)
