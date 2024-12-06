import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class AddressModal extends StatefulWidget {
  final Future<void> Function(LatLng, String, bool) onFinished;
  final LatLng? initialLocation; // Optional initial location for update
  final String? initialAddressName;

  const AddressModal({
    super.key,
    required this.onFinished,
    this.initialLocation,
    this.initialAddressName,
  });

  @override
  _AddressModalState createState() => _AddressModalState();
}

class _AddressModalState extends State<AddressModal> {
  LatLng? _selectedLocation; // To store latitude and longitude
  String _selectedAddress = "Select Location"; // To store the address name
  String _currentAddressName = ''; // To store the address name input
  String? addressNameError; // To handle error if the address name is empty

  LatLng _currentLocation =
      const LatLng(10.4833333, -66.83333333); // Default location

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _selectedLocation = widget.initialLocation;
      _selectedAddress = widget.initialAddressName ?? "Unknown Location";
      _currentAddressName = widget.initialAddressName ?? '';
      _currentLocation = widget.initialLocation!;
    } else {
      _fetchCurrentLocation();
    }
  }

  // Function to get the current location
  Future<void> _fetchCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _selectedAddress = "Location permission denied";
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final LatLng currentLatLng =
          LatLng(position.latitude, position.longitude);

      setState(() {
        _currentLocation = currentLatLng;
      });
    } catch (e) {
      setState(() {
        _selectedAddress = "Failed to fetch location";
      });
    }
  }

  // Function to select a location on the map
  Future<void> _selectLocationOnMap(BuildContext context) async {
    LatLng? location;
    String? locationName;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Select Location'),
        ),
        body: FlutterMap(
          options: MapOptions(
            initialCenter: _currentLocation,
            initialZoom: 16.0,
            onTap: (tapPosition, latLng) {
              location = latLng;
              Navigator.pop(context);
            },
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.app',
            ),
          ],
        ),
      ),
    );

    if (location != null) {
      locationName = await _getLocationName(location!);

      setState(() {
        _selectedLocation = location;
        _selectedAddress = locationName ?? "Unknown Location";
      });
    }
  }

  // Function to get the name of the location using its lat and long
  Future<String?> _getLocationName(LatLng latLng) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${latLng.latitude}&lon=${latLng.longitude}',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['display_name'] ?? 'Unknown Location';
    } else {
      print('Error fetching location name: ${response.statusCode}');
      return null;
    }
  }

  bool isFinishButtonEnabled() {
    return _selectedLocation != null &&
        _currentAddressName.isNotEmpty &&
        addressNameError == null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _selectLocationOnMap(context),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _selectedLocation == null ? Colors.red : Colors.green,
                  width: 3, // Border width
                ),
              ),
              child: CircleAvatar(
                radius: 120,
                backgroundColor: Colors.grey[300],
                backgroundImage: _selectedLocation != null
                    ? const AssetImage('images/placeholder_map.jpg')
                    : null,
                child: _selectedLocation == null
                    ? const Icon(
                        Icons.map,
                        size: 80,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.check,
                        size: 80,
                        color: Colors.green,
                      ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _selectedAddress,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: (value) {
              setState(() {
                _currentAddressName = value;
                addressNameError = value.isNotEmpty
                    ? null
                    : "Please provide a name for this address";
              });
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: "Address Name",
              hintText: "Insert this address name",
              errorText: addressNameError,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              hintStyle: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.normal),
              filled: true,
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: const Icon(Icons.pin_drop),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: isFinishButtonEnabled()
                  ? () {
                      if (_selectedLocation != null) {
                        if (widget.initialAddressName != null) {
                          widget.onFinished(
                              _selectedLocation!,
                              _currentAddressName,
                              true); // Finish the address update
                        } else {
                          widget.onFinished(
                              _selectedLocation!,
                              _currentAddressName,
                              false); // Finish the address addition
                        }
                      }
                    }
                  : null,
              child: Text(
                widget.initialLocation == null
                    ? "Add Address"
                    : "Update Address",
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: colors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pop(context); // Close the modal
              },
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 18, color: colors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
