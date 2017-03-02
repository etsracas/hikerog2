/*
　 地理院地図のタイルの座標系は世界測地系(WGS84 EPSG:4326)だが、
   球面メルカトル図法(EPSG:3857)に変換する */
var view = new ol.View({
  projection: "EPSG:3857",
  center: ol.proj.transform([0, 0], "EPSG:4326", "EPSG:3857"),
  maxZoom: 17,
  zoom: 2
});

//国土地理院地図
var cyberj = new ol.layer.Tile({
  source: new ol.source.XYZ({
    attributions: [
      new ol.Attribution({
        html: "<a href='http://www.gsi.go.jp/kikakuchousei/kikakuchousei40182.html' target='_blank'>国土地理院</a>"
      })
    ],
    url: "http://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png",
    projection: "EPSG:3857"
  })
});

var kml_vector = new ol.layer.Vector({
  source: new ol.source.Vector({
    url: 'http://192.168.33.10:3000/uploads/yamalog/2014-06-29_06-31-17.kml',
    format: new ol.format.KML()
  })
});

var map = new ol.Map({
  target: "map_canvas",
  renderer: ['canvas', 'dom'],
  layers: [cyberj, kml_vector],
  view: view
});

// Each time user clicks the button...
$(window).load(function() {
  var extent = kml_vector.getSource().getExtent();
  map.getView().fit(extent, map.getSize());
});
