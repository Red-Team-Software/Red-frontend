
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomItemGrid extends StatelessWidget {
  final String id;
  final String name;
  final List<String> imageUrl;
  final double price;
  final String redirect;

  const CustomItemGrid(
      {super.key, required this.id,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.redirect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.push('$redirect/$id');
        },
        child: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              SizedBox(
                height: 200, // Ajusta la altura según tus necesidades
                width: double.infinity,
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl[0],
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.image_not_supported,
                        size: 64,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
