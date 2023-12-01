import 'package:flutter/material.dart';

class CustomNotchedShape extends NotchedShape {
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(98, -88)
      ..quadraticBezierTo(
        host.width / 12, // Au lieu de widthSplit
        host.height / 4, // Au lieu de heightSplit
        host.width / 6, // 2 * widthSplit
        host.height / 4, // heightSplit
      )
      ..lineTo(
          host.width * 5 / 6, host.height / 4) // 10 * widthSplit, heightSplit
      ..quadraticBezierTo(
        host.width * 11 / 12, // 11 * widthSplit
        host.height / 4, // heightSplit
        host.right, // Au lieu de width
        host.top, // Au lieu de 0
      )
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();

    return path;
  }

  Path getInnerPath(Rect host, Rect guest) {
    return Path();
  }
}
