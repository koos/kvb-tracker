$ ->

  map = new OpenLayers.Map 'map', {}

  wms_layer_map = new OpenLayers.Layer.WMS "Base layer", "http://vmap0.tiles.osgeo.org/wms/vmap0",
    layers: "basic"
  ,
    isBaseLayer: true

  wms_layer_labels = new OpenLayers.Layer.WMS("Location Labels", "http://vmap0.tiles.osgeo.org/wms/vmap0",
    layers: "clabel,ctylabel,statelabel"
    transparent: true
  ,
    opacity: .5
  )

  map.addLayers [wms_layer_map, wms_layer_labels]
