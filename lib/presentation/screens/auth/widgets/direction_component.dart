import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DirectionComponent extends StatefulWidget {
  final void Function(int) onChangeIndex;
  final void Function(LatLng) onChangeLocation;
  final void Function(String) onChangeAddressName;
  final Future<void> Function() onFinished;


  const DirectionComponent({
    super.key, 
    required this.onChangeIndex,
    required this.onChangeLocation,
    required this.onChangeAddressName,
    required this.onFinished,
  });

  @override
  _DirectionComponentState createState() => _DirectionComponentState();
}

class _DirectionComponentState extends State<DirectionComponent> {
  LatLng? _selectedLocation; // Para almacenar latitud y longitud
  String _selectedAddress = "Select Location"; // Para almacenar el nombre de la dirección
  String _currentAddressName = ''; // Para almacenar el nombre de la dirección
  String? addressNameError;

  LatLng _currentLocation = const LatLng(10.4833333, -66.83333333); // Ubicación inicial

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      // Solicitar permisos de ubicación
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _selectedAddress = "Location permission denied";
        });
        return;
      }

      // Obtener la posición actual
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

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
            initialZoom: 18.0,
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Mapa en un círculo
        GestureDetector(
          onTap: () => _selectLocationOnMap(context),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _selectedLocation == null ? Colors.red : Colors.green,
                width: 3, // Ancho del borde
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
          )
        ),
        const SizedBox(height: 10),
        // Mostrar la dirección seleccionada
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
        // Botones
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
              widget.onChangeLocation(_selectedLocation!); // ¡Sin errores ahora!
              widget.onChangeAddressName(_currentAddressName);
              widget.onFinished(); // Llama al registro en AuthScreen
            }
          }
        : null,
            child: const Text(
              "Finish",
              style: TextStyle(fontSize: 18, color: Colors.white),
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
              widget.onChangeIndex(2); // Regresar a la pantalla anterior
            },
            child: Text(
              "Back",
              style: TextStyle(fontSize: 18, color: colors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
