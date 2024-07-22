import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0); // Start at the top-left corner
    path.quadraticBezierTo(
      size.width / 4, 60, // Control point for the wave
      size.width / 2, 0, // End point of the first wave
    );
    path.quadraticBezierTo(
      3 * size.width / 4, 0, // Control point for the second wave
      size.width, 60, // End point of the second wave
    );
    path.lineTo(size.width, size.height); // Draw to bottom-right corner
    path.lineTo(0, size.height); // Draw to bottom-left corner
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
