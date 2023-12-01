import 'package:flutter/widgets.dart';

class ProfileContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final widthPart = 3 * width / 10;
    final corner = widthPart / 3;
    Path path = Path()
      ..moveTo(0, corner)
      ..lineTo(widthPart, corner)
      ..quadraticBezierTo(widthPart, 0, widthPart + corner, 0)
      ..lineTo(width - widthPart - corner, 0)
      ..quadraticBezierTo(width - widthPart, 0, width - widthPart, corner)
      ..lineTo(width, corner)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..lineTo(0, corner)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
