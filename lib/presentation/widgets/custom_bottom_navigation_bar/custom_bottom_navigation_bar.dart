import 'package:GoDeli/presentation/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/presentation/widgets/custom_bottom_navigation_bar/bottom_navigation_center_icon.dart';
import 'package:GoDeli/presentation/widgets/custom_bottom_navigation_bar/bottom_navigation_decorator.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.items1,
    required this.items2,
    required this.currentIndex,
    required this.onItemTapped,
  });

  final List<CustomBottomNavigationItem> items1;
  final List<CustomBottomNavigationItem> items2;
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      width: size.width,
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomPainter(
              backgroundColor: theme.brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          Positioned(
            bottom: 45,
            left: (size.width - 70) / 2,
            child: const BottomNavigationCenterIcon(),
          ),
          BottomNavigationDecoration(
            size: size,
            items1: items1,
            items2: items2,
            currentIndex: currentIndex,
            onItemTapped: onItemTapped,
          ),
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  final Color backgroundColor;

  BNBCustomPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    Path path = Path();

    path.moveTo(0, 0); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 5);
    path.arcToPoint(Offset(size.width * 0.60, 5),
        radius: const Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
