import 'package:flutter/material.dart';

class DeliveryTimeSection extends StatefulWidget {
  const DeliveryTimeSection({super.key});

  @override
  _DeliveryTimeSectionState createState() => _DeliveryTimeSectionState();
}

class _DeliveryTimeSectionState extends State<DeliveryTimeSection> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Preferred delivery time',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white, // Fondo negro
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate != null
                      ? '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}'
                      : 'Select delivery date',
                  style: const TextStyle(
                      fontSize: 16, color: Colors.black), // Texto en blanco
                ),
                const Icon(Icons.calendar_today,
                    color: Colors.black), // Icono en blanco
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => _selectTime(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white, // Fondo negro
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedTime != null
                      ? _selectedTime!.format(context)
                      : 'Select delivery time',
                  style: const TextStyle(
                      fontSize: 16, color: Colors.black), // Texto en blanco
                ),
                const Icon(Icons.access_time,
                    color: Colors.black), // Icono en blanco
              ],
            ),
          ),
        ),
      ],
    );
  }
}
