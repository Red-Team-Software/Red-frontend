import 'package:flutter/material.dart';

enum SnackBarType { info, warning, success, error }

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required SnackBarType type,
    required String title,
    required String message,
  }) {
    final backgroundColor = _getBackgroundColor(type);
    final icon = _getIcon(type);

    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(bottom: 20.0, left: 16.0, right: 16.0),
      content: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Icon(icon, color: Colors.white),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.info:
        return Colors.lightBlue;
      case SnackBarType.success:
        return Colors.lightGreen;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.warning:
        return Colors.yellow;
      default:
        return Colors.black;
    }
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.info:
        return Icons.info_outline;
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.error:
        return Icons.error_outline_outlined;
      case SnackBarType.warning:
        return Icons.warning_amber_outlined;
      default:
        return Icons.info_outline;
    }
  }
}
