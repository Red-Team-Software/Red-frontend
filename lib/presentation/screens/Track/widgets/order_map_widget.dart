import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class OrderMapWidget extends StatefulWidget {
  final double userLatitude;
  final double userLongitude;
  final double deliveryLatitude;
  final double deliveryLongitude;

  const OrderMapWidget({
    super.key,
    required this.userLatitude,
    required this.userLongitude,
    required this.deliveryLatitude,
    required this.deliveryLongitude,
  });

  @override
  State<OrderMapWidget> createState() => _OrderMapWidgetState();
}

class _OrderMapWidgetState extends State<OrderMapWidget> {
  late MapboxMap mapboxMap;

  @override
  void initState() {
    super.initState();
    // Configura el token de Mapbox
    MapboxOptions.setAccessToken(
      "pk.eyJ1IjoiZGltZWJyaWkiLCJhIjoiY201d3B5eWJ0MDBxYzJpcHRleTA2MjBlZyJ9.asGCuRxG-jUItZNv4k-3xw",
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: MapWidget(
        key: const ValueKey("mapWidget"),
        cameraOptions: CameraOptions(
          center: Point(
            coordinates: Position(
              widget.userLongitude,
              widget.userLatitude,
            ),
          ),
          zoom: 12.0,
        ),
        onMapCreated: _onMapCreated,
      ),
    );
  }

  void _onMapCreated(MapboxMap map) async {
    mapboxMap = map;

    // Define GeoJSON source for the route
    final routeGeoJson = jsonEncode({
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "geometry": {
            "type": "LineString",
            "coordinates": [
              [widget.userLongitude, widget.userLatitude],
              [widget.deliveryLongitude, widget.deliveryLatitude]
            ]
          }
        }
      ]
    });

    // Add source to the map
    await mapboxMap.style.addSource(
      GeoJsonSource(
        id: "route",
        data: routeGeoJson as String?,
      ),
    );

    // Add a line layer to display the route
    await mapboxMap.style.addLayer(
      LineLayer(
        id: "route-layer",
        sourceId: "route",
        lineColor: Colors.red.value,
        lineWidth: 5.0,
      ),
    );

    // Add markers for user and delivery locations
    await _addMarkers();
  }

  Future<void> _addMarkers() async {
    final pointAnnotationManager =
        await mapboxMap.annotations.createPointAnnotationManager();

    // Marker for user location
    await pointAnnotationManager.create(
      PointAnnotationOptions(
        geometry: Point(
          coordinates: Position(
            widget.userLongitude,
            widget.userLatitude,
          ),
        ),
        image: await _loadAssetImage("assets/user_marker.png"),
      ),
    );

    // Marker for delivery location
    await pointAnnotationManager.create(
      PointAnnotationOptions(
        geometry: Point(
          coordinates: Position(
            widget.deliveryLongitude,
            widget.deliveryLatitude,
          ),
        ),
        image: await _loadAssetImage("assets/delivery_marker.png"),
      ),
    );
  }

  Future<Uint8List> _loadAssetImage(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }
}
