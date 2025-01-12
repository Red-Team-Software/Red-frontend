import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this import

class BottomNavigationCenterIcon extends StatelessWidget {
  const BottomNavigationCenterIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: SizedBox.fromSize(
        size: const Size(70, 70),
        child: InkWell(
          child: SvgPicture.string(
            '''<svg id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 368.13 437.65"><defs><style>.cls-1{fill:#fe0000;}</style></defs><title>PruebaIcono</title><path class="cls-1" d="M456.84,438.37C439.51,464,416.33,483,395.65,504.29c-25.41,26.17-51.44,51.74-77.27,77.51-8.45,8.42-17.73,9-26,.65-41.71-41.9-84.86-82.53-124.44-126.38C74.49,352.53,128.2,186.8,264.24,155.43,367,131.74,470.45,200.55,486.73,304c7.57,48.15-1.91,93-29.89,134.39M350.57,388.92c10.13-2.57,12.86-11.13,15.26-19.55,5-17.52,9.6-35.14,14.29-52.74,4.73-17.76,2.83-20.24-15.44-20.24q-52.95,0-105.91.05c-20.44,0-20.44,0-26-20.22-4.94-17.93-8.32-20.16-26.92-17.85-4.44.56-9.24,1-9.17,7,.06,5.09,3.64,8.78,8.26,8.41,10.94-.88,13,6.3,15.15,14.27q11.34,41.85,22.93,83.62c2.73,9.88,8.2,18.44,19,18.68,28.88.65,57.82,2.06,88.54-1.44m-20.71,19a49.77,49.77,0,0,0-4.3,5.59c-5.87,10.15-1.38,24.24,9.55,30.37,9.51,5.32,21.42,1.86,27.65-8.05,5.74-9.14,5.17-17.94-1.82-26.09-7.76-9-16.66-9.81-31.08-1.82m-83.41,2.63c-8.16,13.62-4.49,27.86,8.77,34,11.24,5.17,24-.73,28.73-13.51,3.63-9.85.32-18-7.43-24.34C267.83,399.52,258.58,400.51,246.45,410.52Z" transform="translate(-121.11 -150.75)"/></svg>''',
            width: 40,
            height: 40,
            color: colors.primary, // Change color to red
          ),
          onTap: () {
            context.push('/cart');
          },
        ),
      ),
    );
  }
}
