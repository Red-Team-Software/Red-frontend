
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomButtonArrowImage extends StatelessWidget {
  const CustomButtonArrowImage({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      child: InkWell(
        onTap: () => context.pop(),
        child: Center(
          child: Container(
            padding:
                const EdgeInsets.only(left: 16, right: 8, top: 6, bottom: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child:
                const Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}