import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_bloc.dart';
import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_event.dart';
import 'package:GoDeli/features/checkout/aplication/Bloc/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'address_card.dart';

class ShippingAddressSection extends StatelessWidget {
  const ShippingAddressSection({super.key});

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
              return AddressCard(
                title: address.title,
                address: address.location,
                isSelected: address == state.selectedAddress,
                onSelect: () {
                  checkoutBloc.add(SelectAddress(address));
                },
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
                        onTap: () async {
                          final selectedLocation =
                              await _selectLocationOnMap(context);
                          if (selectedLocation != null) {
                            setState(() {
                              location = selectedLocation;
                            });
                          }
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
                                  overflow:
                                      TextOverflow.ellipsis, // Limita el texto
                                  maxLines: 1,
                                ),
                              ),
                              const Icon(Icons.map, color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed:
                            title.isNotEmpty && location != 'Select on map'
                                ? () {
                                    bloc.add(AddNewAddress(title, location));
                                    Navigator.pop(context);
                                  }
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          minimumSize:
                              const Size.fromHeight(48), // Ocupa todo el ancho
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

  Future<String?> _selectLocationOnMap(BuildContext context) async {
    LatLng? selectedLocation;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Select Location')),
        body: FlutterMap(
          options: MapOptions(
            initialCenter:
                const LatLng(10.4833333, -66.83333333), // Ubicación inicial
            initialZoom: 13.0,
            onTap: (tapPosition, latLng) {
              selectedLocation = latLng;
              Navigator.pop(context);
            },
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName:
                  'com.example.app', // Ajusta el nombre del paquete
              subdomains: const ['a', 'b', 'c'],
            ),
          ],
        ),
      ),
    );

    if (selectedLocation != null) {
      final locationName = await _getLocationName(selectedLocation!);
      return locationName;
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
