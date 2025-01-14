import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_bloc.dart';
import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_event.dart';
import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_state.dart';
import 'package:GoDeli/features/checkout/domain/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'address_card.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tuple/tuple.dart';
import 'package:geolocator/geolocator.dart';

class ShippingAddressSection extends StatefulWidget {
  const ShippingAddressSection({super.key});

  @override
  _ShippingAddressSectionState createState() => _ShippingAddressSectionState();
}

class _ShippingAddressSectionState extends State<ShippingAddressSection> {
  @override
  void initState() {
    super.initState();
    context.read<CheckoutBloc>().add(FetchAddressesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final checkoutBloc = context.read<CheckoutBloc>();

    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shipping to',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...state.addresses.map((address) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          checkoutBloc.add(RemoveAddressEvent(address));
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                    ],
                  ),
                  child: AddressCard(
                    title: address.title,
                    address: address.location,
                    isSelected: address == state.selectedAddress,
                    onSelect: () {
                      checkoutBloc.add(SelectAddress(address));
                    },
                  ),
                ),
              );
            }),
            TextButton(
              onPressed: () => _showAddAddressModal(context, checkoutBloc),
              child: const Text(
                'Add new address',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddAddressModal(
      BuildContext context, CheckoutBloc bloc) async {
    String title = '';
    String location = 'Select on map';
    num lat = 0;
    num lng = 0;
    bool isLoading = false;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Address Title',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: isLoading
                            ? null
                            : () async {
                                setState(() {
                                  isLoading = true;
                                });
                                final selectedLocation =
                                    await _selectLocationOnMap(context);
                                if (selectedLocation != null) {
                                  setState(() {
                                    location = selectedLocation.item1!;
                                    lat = selectedLocation.item2!;
                                    lng = selectedLocation.item3!;
                                  });
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  location,
                                  style: const TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Icon(Icons.map,
                                  color: isLoading ? Colors.grey : Colors.red),
                            ],
                          ),
                        ),
                      ),
                      if (isLoading)
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            'Obtaining current location...',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: title.isNotEmpty &&
                                location != 'Select on map'
                            ? () {
                                bloc.add(
                                    AddNewAddress(title: title, location: location, lat: lat, lng: lng));
                                Navigator.pop(context);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          minimumSize: const Size.fromHeight(48),
                        ),
                        child: const Text(
                          'Save Address',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showEditAddressModal(
      BuildContext context, CheckoutBloc bloc, Address address) async {
    String title = address.title;
    String location = address.location;
    bool isLoading = false;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Address Title',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                        controller: TextEditingController(text: title),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: isLoading
                            ? null
                            : () async {
                                setState(() {
                                  isLoading = true;
                                });
                                final selectedLocation =
                                    await _selectLocationOnMap(context);
                                if (selectedLocation != null) {
                                  setState(() {
                                    location = selectedLocation.item1!;
                                  });
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  location,
                                  style: const TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Icon(Icons.map,
                                  color: isLoading ? Colors.grey : Colors.red),
                            ],
                          ),
                        ),
                      ),
                      if (isLoading)
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            'Obtaining current location...',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: title.isNotEmpty &&
                                location != 'Select on map'
                            ? () {
                                bloc.add(UpdateAddressEvent(address.copyWith(
                                    title: title, location: location)));
                                Navigator.pop(context);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          minimumSize: const Size.fromHeight(48),
                        ),
                        child: const Text(
                          'Update Address',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<Tuple3<String?, num?, num?>?> _selectLocationOnMap(
      BuildContext context) async {
    LatLng? selectedLocation;

    // Check location permissions
    if (await Permission.location.isGranted) {
      print("Location permission already granted");
      // Fetch current device location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      selectedLocation = LatLng(position.latitude, position.longitude);
    } else {
      print("Requesting location permission");
      // Request location permission
      if (await Permission.location.request().isGranted) {
        print("Location permission granted");
        // Fetch current device location
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        selectedLocation = LatLng(position.latitude, position.longitude);
      } else {
        // Show modal requesting location permission
        bool? permissionGranted = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Location Permission'),
            content: const Text(
                'This app needs location access to show your current location on the map.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Deny'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Allow'),
              ),
            ],
          ),
        );

        if (permissionGranted == true) {
          print("User allowed location permission");
          // Request location permission again
          if (await Permission.location.request().isGranted) {
            print("Location permission granted after user allowed");
            // Fetch current device location
            Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            selectedLocation = LatLng(position.latitude, position.longitude);
          }
        }
      }
    }

    // Hide system UI elements
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Select Location'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              // Restore system UI elements
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
              Navigator.pop(context);
            },
          ),
        ),
        body: FlutterMap(
          options: MapOptions(
            initialCenter:
                selectedLocation ?? const LatLng(10.4833333, -66.83333333),
            initialZoom: 16.0,
            onTap: (tapPosition, latLng) {
              selectedLocation = latLng;
              // Restore system UI elements
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
              Navigator.pop(context);
            },
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.example.app',
              subdomains: const ['a', 'b', 'c'],
            ),
          ],
        ),
      ),
    );

    // Restore system UI elements if the user dismisses the bottom sheet without selecting a location
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    if (selectedLocation != null) {
      final locationName = await _getLocationName(selectedLocation!);
      return Tuple3(locationName, selectedLocation?.latitude,
          selectedLocation?.longitude);
    }

    return null;
  }

  Future<String?> _getLocationName(LatLng latLng) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${latLng.latitude}&lon=${latLng.longitude}',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['display_name'] ?? 'Unknown location';
    } else {
      print('Error al obtener la dirección: ${response.statusCode}');
      return null;
    }
  }
}
