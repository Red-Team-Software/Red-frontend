import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileAddressCard extends StatefulWidget {
  final String id;
  final String addressName;
  final String address;
  final double latitude;
  final double longitude;
  final bool isFavorite;
  // final VoidCallback onSelect;
  final VoidCallback onUpdate;
  final Future<void> Function(String id, bool isFavorite) onFavoriteChanged;

  const ProfileAddressCard({
    super.key,
    required this.id,
    required this.addressName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.isFavorite,
    required this.onFavoriteChanged,
    required this.onUpdate,
  });

  @override
  _ProfileAddressCardState createState() => _ProfileAddressCardState();
}

class _ProfileAddressCardState extends State<ProfileAddressCard> {
  bool _isFavorite = false;
  bool _isLoading = false;
  String _addressName = '';

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
    _addressName = widget.address;
    if (_addressName.isEmpty) _getAddressName(); // Obtener el nombre de la dirección cuando se inicializa
  }

  Future<void> _getAddressName() async {
    final address =
        await _getLocationName(LatLng(widget.latitude, widget.longitude));
    if (address != null) {
      setState(() {
        _addressName = address;
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
      return null;
    }
  }

  void _toggleFavorite() async {
    setState(() {
      _isLoading = true;
    });

    // Hacer la petición al backend para actualizar el estado del favorito
    await widget.onFavoriteChanged(widget.id, !_isFavorite);

    setState(() {
      _isFavorite = !_isFavorite;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _isFavorite ? Colors.grey[300] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: IconButton(
          icon: _isLoading
              ? const CircularProgressIndicator()
              : Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.grey,
                ),
          onPressed: _isLoading ? null : _toggleFavorite,
        ),
        title: Text(widget.addressName),
        subtitle:
            Text(_addressName), // Mostrar el nombre de la dirección obtenida
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: widget.onUpdate,
        ),
      ),
    );
  }
}
