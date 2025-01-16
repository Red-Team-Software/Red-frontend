import 'package:flutter/material.dart';
import 'package:GoDeli/features/order/domain/order.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderCourierCard extends StatelessWidget {
  final Courier courier;

  const OrderCourierCard({super.key, required this.courier});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    void launchCaller(String phoneNumber) async {
      final url = 'tel:+$phoneNumber';
      try {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          print('Could not launch $url');
          throw 'Could not launch $url';
        }
      } catch (e, stacktrace) {
        print('Error launching $url: $e');
        print(stacktrace);
      }
    }

    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(courier.courierImage, width: 70, height: 70),
        ),
        title: Text('Courier',
            style:
                TextStyle(color: colors.primary, fontWeight: FontWeight.w600)),
        subtitle: Row(
          children: [
            Text(courier.courierName, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                // launchCaller(courier.courierPhone);
                print('Call functionality is currently disabled.');
              },
              child: Text('+${courier.courierPhone}',
                  style: TextStyle(color: colors.primary)),
            ),
          ],
        ),
      ),
    );
  }
}
