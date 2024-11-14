import 'package:flutter/material.dart';
import 'address_card.dart';

class ShippingAddressSection extends StatelessWidget {
  const ShippingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping to',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const AddressCard(
          title: 'Home',
          address: 'Av Principal de bello campo, edif tupamaro',
          isSelected: true,
        ),
        const AddressCard(
          title: 'Office',
          address:
              'Casita de bryan, al frente del guaire traigan mujeres (vivas opcional)',
          isSelected: false,
        ),
        TextButton(
          onPressed: () {
            // TODO: Añadir lógica para agregar nueva dirección
          },
          child: const Text(
            'Add new address',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
