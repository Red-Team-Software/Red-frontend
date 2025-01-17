import 'package:flutter/material.dart';

const double defaultPadding = 16.0;

class SkeletonScreen extends StatelessWidget {
  const SkeletonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => (),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black.withOpacity(0.5),
            ),
        ),
        title: const SkeletonWidget(
          height: 24,
          width: 100,
        ),
      ),
      body: const SkeletonWidget(
        height: 100,
        width: double.infinity,
      )
    );
  }
}

class SkeletonWidget extends StatelessWidget {
  const SkeletonWidget({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius:
              const BorderRadius.all(Radius.circular(defaultPadding))),
    );
  }
}