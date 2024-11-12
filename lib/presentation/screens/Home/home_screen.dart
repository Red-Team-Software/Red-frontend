import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.grid_view_outlined,
          size: 48,
        ),
        title: const Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Deliver to',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Direccion Ejemplo: Guarenas, Miranda',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flex(direction: Axis.horizontal, children: [
                      const Text('Get your ',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w300)),
                      Text(
                        'groceries',
                        style: TextStyle(
                            fontSize: 40,
                            color: colors.primary,
                            fontWeight: FontWeight.bold),
                      )
                    ]),
                    const Text(
                      'delivered quikly',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
