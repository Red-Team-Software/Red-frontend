import 'package:GoDeli/presentation/screens/profile/widgets/addess_modal.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class AddressCard extends StatelessWidget {
  final String title;
  final String address;
  final bool isSelected;
  final LatLng location;
  final VoidCallback onSelect;

  const AddressCard({
    super.key,
    required this.title,
    required this.address,
    required this.isSelected,
    required this.location,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.grey[300] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(isSelected
            ? Icons.radio_button_checked
            : Icons.radio_button_unchecked),
        title: Text(title),
        subtitle: Text(address),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => AddressModal(
                onFinished: (LatLng location, String addressName, bool isUpdate,
                    String locationName) async {
                  print("FGinal$location");
                  return;
                },
                initialLocation:
                    location, // Replace with actual initial location
                initialLocationName: title,
                initialAddressName: address,
              ),
            );
          },
        ),
        onTap: onSelect,
      ),
    );
  }
}
