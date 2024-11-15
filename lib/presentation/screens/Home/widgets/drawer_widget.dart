import 'package:GoDeli/presentation/core/drawer/drawer_items.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final VoidCallback closeDrawer;

  const DrawerWidget({super.key, required this.closeDrawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          onPressed: closeDrawer,
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mi nombre',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                      ),
                      Text('O412-1231231',
                          style: TextStyle(color: Colors.white, fontSize: 14))
                    ],
                  )
                ],
              ),
            ),
            buildDrawerItems()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        label: const Text('Logout'),
        icon: const Icon(Icons.logout),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Widget buildDrawerItems() => Column(
        children: DrawerItems.all
            .map((item) => ListTile(
                  enableFeedback: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  leading: Icon(
                    item.icon,
                    color: Colors.white,
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {},
                ))
            .toList(),
      );
}
