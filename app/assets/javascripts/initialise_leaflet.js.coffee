$ ->
  window.informationWindow = $("#info")
  window.linesCounter = $("#lines_counter")
  window.lines = $("#lines")
  window.pushesCounter = $("#pushes_counter")
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
pusher  = new Pusher 'fd7d5bc8f36413a2163d'
channel = pusher.subscribe 'default'
window.lineCount = 0
window.pushesCount = 0
channel.bind 'vehicle_update', (data)->
  pushesCount += 1
  pushesCounter.html(pushesCount)
  if $("#"+data.line).length == 0
    lines.append("<span id='"+data.line+"'>"+data.line+",</span>")
    lineCount += 1
    linesCounter.html(lineCount)
  newPosition = new L.LatLng(data.position[0], data.position[1])
  if window.markers[data.id] != undefined
    # console.log("------------------ Moving Marker #{data.id} #{newPosition} ------------------ ")
    window.markers[data.id].setLatLng(newPosition)
    window.subWindow = $("#"+data.id)
    window.subWindow.append("<br/>--- "+data.position)
    informationWindow.append("<div id='"+data.line+"'>Linie "+ data.line+" Id: "+data.id+" "+data.destination+"<br/>--- "+data.position+"</p></div>")
  else
    # console.log("------------------ New Marker #{data.id} ------------------ ")
    window.markers[data.id] = new L.Marker(newPosition, {icon: window.icon})
    window.map.addLayer(window.markers[data.id])
    window.markers[data.id].bindPopup("<strong>Linie "+ data.line+" Id: "+data.id+"<br />"+data.destination+"</strong>")
    informationWindow.append("<div id='"+data.id+"'>Linie "+ data.line+" Id: "+data.id+" "+data.destination+"<br/>--- "+data.position+"</div>")