import 'package:flutter/widgets.dart';

class NotificationClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final midHeight = height / 2;
    final corner = height / 7;
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(width, 0)
      ..lineTo(width, midHeight - corner)
      ..quadraticBezierTo(width - corner, midHeight, width, midHeight + corner)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..lineTo(0, midHeight + corner)
      ..quadraticBezierTo(corner, midHeight, 0, midHeight - corner)
      ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
