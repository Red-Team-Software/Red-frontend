import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  const ImageComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/logo.png', // Añade el logo en tu carpeta de assets
      height: 200,
    );
  }
}
