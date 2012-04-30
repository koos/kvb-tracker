$ ->
  map = new L.Map('map')
  window.map = map
  window.markers = {}

  cloudmade = new L.TileLayer 'http://{s}.tile.cloudmade.com/3b477058df1d402fb1ea6f45611880e9/997/256/{z}/{x}/{y}.png'
    ,
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
      maxZoom: 18

  cologne = new L.LatLng(50.9293001, 6.9577079)
  map.setView(cologne, 13).addLayer(cloudmade)

MyIcon = L.Icon.extend({options:{
    iconUrl: '/assets/images/type_1.png',
    iconSize: new L.Point(25, 25),
    shadowSize: new L.Point(68, 95),
    iconAnchor: new L.Point(22, 94),
    popupAnchor: new L.Point(-3, -76)
}})
window.icon = new MyIcon()

# Enable pusher logging
Pusher.log = (message) ->
  window.console.log(message)  if (window.console && window.console.log)
  # Flash fallback logging
  WEB_SOCKET_DEBUG = true

console.log("pusher")
pusher  = new Pusher 'fd7d5bc8f36413a2163d'
channel = pusher.subscribe 'default'
channel.bind 'vehicle_update', (data)->
  newPosition = new L.LatLng(data.position[0], data.position[1])
  
  if window.markers[data.id] != undefined
    window.markers[data.id].setLatLng(newPosition)
  else
    window.markers[data.id] = new L.Marker(newPosition, {icon: window.icon})
    window.map.addLayer(window.markers[data.id])
    window.markers[data.id].bindPopup("<strong>Linie "+ data.line+" Id: "+data.id+"<br />"+data.destination+"</strong>")