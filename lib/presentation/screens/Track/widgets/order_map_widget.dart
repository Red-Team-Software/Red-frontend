import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class OrderMapWidget extends StatefulWidget {
  final double userLatitude;
  final double userLongitude;
  final double? deliveryLatitude; // Make optional
  final double? deliveryLongitude; // Make optional

  const OrderMapWidget({
    super.key,
    required this.userLatitude,
    required this.userLongitude,
    this.deliveryLatitude, // Make optional
    this.deliveryLongitude, // Make optional
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Set the border radius here
        child: MapWidget(
          key: const ValueKey("mapWidget"),
          cameraOptions: CameraOptions(
            center: Point(
              coordinates: Position(
                (widget.userLongitude +
                        (widget.deliveryLongitude ?? widget.userLongitude)) /
                    2,
                (widget.userLatitude +
                        (widget.deliveryLatitude ?? widget.userLatitude)) /
                    2,
              ),
            ),
            zoom: _calculateZoomLevel(),
          ),
          onMapCreated: _onMapCreated,
        ),
      ),
    );
  }

  double _calculateZoomLevel() {
    if (widget.deliveryLatitude == null || widget.deliveryLongitude == null) {
      return 14.0; // Default zoom level when delivery location is not provided
    }
    // Calculate the zoom level based on the distance between the two points
    final distance = _calculateDistance(
      widget.userLatitude,
      widget.userLongitude,
      widget.deliveryLatitude!,
      widget.deliveryLongitude!,
    );
    return 12.0 - (distance / 10.0); // Adjust the divisor as needed
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295; // Pi/180
    final a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  void _onMapCreated(MapboxMap map) async {
    mapboxMap = map;

    if (widget.deliveryLatitude != null && widget.deliveryLongitude != null) {
      // Print the courier's coordinates
      print(
          'Courier coordinates: Latitude ${widget.deliveryLatitude}, Longitude ${widget.deliveryLongitude}');

      // Fetch route data from Mapbox Directions API
      final routeGeoJson = await _fetchRoute();

      // Add source to the map
      await mapboxMap.style.addSource(
        GeoJsonSource(
          id: "route",
          data: routeGeoJson,
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
    }

    // Add markers for user and delivery locations
    await _addMarkers();
  }

  Future<String> _fetchRoute() async {
    final response = await http.get(
      Uri.parse(
        'https://api.mapbox.com/directions/v5/mapbox/driving/${widget.userLongitude},${widget.userLatitude};${widget.deliveryLongitude},${widget.deliveryLatitude}?geometries=geojson&access_token=pk.eyJ1IjoiZGltZWJyaWkiLCJhIjoiY201d3B5eWJ0MDBxYzJpcHRleTA2MjBlZyJ9.asGCuRxG-jUItZNv4k-3xw',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return jsonEncode({
        "type": "FeatureCollection",
        "features": [
          {
            "type": "Feature",
            "geometry": data['routes'][0]['geometry'],
          }
        ]
      });
    } else {
      throw Exception('Failed to load route');
    }
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
        image: await _loadAssetImage("images/user.png"),
      ),
    );

    if (widget.deliveryLatitude != null && widget.deliveryLongitude != null) {
      // Marker for delivery location
      await pointAnnotationManager.create(
        PointAnnotationOptions(
          geometry: Point(
            coordinates: Position(
              widget.deliveryLongitude!,
              widget.deliveryLatitude!,
            ),
          ),
          image: await _loadAssetImage("images/cou.png"),
        ),
      );
    }
  }

  Future<Uint8List> _loadAssetImage(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }
}
