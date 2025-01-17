import 'dart:convert';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class AddressModal extends StatefulWidget {
  final Future<void> Function(LatLng, String, bool, String) onFinished;
  final LatLng? initialLocation; // Optional initial location for update
  final String? initialLocationName;
  final String? initialAddressName;

  const AddressModal({
    super.key,
    required this.onFinished,
    this.initialLocation,
    this.initialAddressName,
    this.initialLocationName,
  });

  @override
  _AddressModalState createState() => _AddressModalState();
}

class _AddressModalState extends State<AddressModal> {
  LatLng? _selectedLocation; // To store latitude and longitude
  String _selectedLocationName = "Select Location"; // To store the address name
  String _currentAddressName = ''; // To store the address name input
  String? addressNameError; // To handle error if the address name is empty

  LatLng _currentLocation =
      const LatLng(10.4833333, -66.83333333); // Default location

  final addressNameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _selectedLocation = widget.initialLocation;
      _selectedLocationName = widget.initialLocationName ?? "";
      _currentLocation = widget.initialLocation!;
      addressNameTextController.text = widget.initialAddressName ?? '';
      _currentAddressName = widget.initialAddressName ?? '';
      if (widget.initialLocationName == null) {
        print('Fetching initial location name');
        _fetchInitialLocationName();
      }
    } else {
      _fetchCurrentLocation();
    }
  }

  Future<void> _fetchInitialLocationName() async {
    final locationName =
        await _getLocationName(_selectedLocation!) ?? 'Unknown Location';

    setState(() {
      _selectedLocationName = locationName;
    });
  }

  // Function to get the current location
  Future<void> _fetchCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _selectedLocationName = "Location permission denied";
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
        _selectedLocationName = "Failed to fetch location";
      });
    }
  }

  // Function to select a location on the map
  Future<void> _selectLocationOnMap(BuildContext context) async {
    LatLng? location;
    String? locationName;
    final language =  context.watch<LanguagesCubit>().state.selected.language;


    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: 
          TranslationWidget(
            message:'Select Location',
            toLanguage: language,
            builder: (translated) => Text(
              translated,
            ), 
          ),
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
        _selectedLocationName = locationName ?? "Unknown Location";
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
    print(
        "Selected Location: $_selectedLocation, Current Address Name: $_currentAddressName, Address Name Error: $addressNameError");

    return _selectedLocation != null &&
            _currentAddressName.isNotEmpty &&
            addressNameError == null ||
        (widget.initialAddressName != null &&
            _selectedLocation != widget.initialLocation &&
            _currentAddressName.isNotEmpty &&
            addressNameError == null);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final language =  context.watch<LanguagesCubit>().state.selected.language;


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
            _selectedLocationName,
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
            controller: addressNameTextController,
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
                              true,
                              _selectedLocationName); // Finish the address update
                        } else {
                          widget.onFinished(
                              _selectedLocation!,
                              _currentAddressName,
                              false,
                              _selectedLocationName); // Finish the address addition
                        }
                      }
                    }
                  : null,
              child: 
              TranslationWidget(
                message: widget.initialLocation == null
                    ? "Add Address"
                    : "Update Address",
                toLanguage: language,
                builder: (translated) => Text(
                    translated,
                    style: const TextStyle(fontSize: 18, color: Colors.white)
                ), 
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
              child: 
              TranslationWidget(
                message:'Cancel',
                toLanguage: language,
                builder: (translated) => Text(
                    translated,
                    style: TextStyle(fontSize: 18, color: colors.primary)
                ), 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
