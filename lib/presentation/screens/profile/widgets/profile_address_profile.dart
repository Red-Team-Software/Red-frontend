
import 'package:flutter/material.dart';

class ProfileAddressCard extends StatelessWidget {
  final String title;
  final String address;
  final bool isSelected;
  final VoidCallback onSelect;

  const ProfileAddressCard({
    super.key,
    required this.title,
    required this.address,
    required this.isSelected,
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
            // TODO: Lógica para editar dirección
          },
        ),
        onTap: onSelect,
      ),
    );
  }
}
