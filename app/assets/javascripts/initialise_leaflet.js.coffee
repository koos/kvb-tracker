$ ->
  map = new L.Map('map')

  cloudmade = new L.TileLayer 'http://{s}.tile.cloudmade.com/3b477058df1d402fb1ea6f45611880e9/997/256/{z}/{x}/{y}.png'
    ,
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
      maxZoom: 18

  # london = new L.LatLng(51.505, -0.09)
  # map.setView(london, 13).addLayer(cloudmade)

  cologne = new L.LatLng(50.9293001, 6.9577079)
  map.setView(cologne, 13).addLayer(cloudmade)

  # markerLocation = new L.LatLng(51.5, -0.09)

  # marker = new L.Marker(markerLocation)
  # map.addLayer(marker)

  _.each [2003475, 1320438, 34411, 36145, 2003477, 36127, 36132, 36133, 2003476, 36134, 34488, 1633562, 2003476], (relation_id) ->
    $.get '/osm/' + relation_id + '.osm', (data) ->
      relation = osm2geo(data)
      geojson = new L.GeoJSON()
      geojson.addGeoJSON(relation)
      map.addLayer(geojson)

  # circleLocation = new L.LatLng(51.508, -0.11)
  # circleOptions =
  #   color: 'red'
  #   fillColor: '#f03'
  #   fillOpacity: 0.5

  # circle = new L.Circle(circleLocation, 500, circleOptions)
  # map.addLayer(circle)


#   var polyline = new L.Polyline(latlngs, {color: 'red'});
# 
# // zoom the map to the polyline
# map.fitBounds(new L.LatLngBounds(latlngs));
# 
# // add the polyline to the map
# map.addLayer(polyline);
