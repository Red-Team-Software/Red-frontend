import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class ImagesCarrusel extends StatelessWidget {
  final List<String> images;
  final double height = 300.0;

  const ImagesCarrusel({required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.length == 1) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: Image.network(
          images[0],
          fit: BoxFit.fill,
        ),
      );
    }

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            images[index],
            fit: BoxFit.fill,
          );
        },
        itemHeight: height,
        itemCount: images.length,
        pagination: const SwiperPagination(
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}