import 'package:flutter/material.dart';

class BottomBarCustomed extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
    final widthSplit = width / 12;
    final heightSplit = height / 4;
    final space = height / 10;

    path
      ..moveTo(0, space)
      ..quadraticBezierTo(
        widthSplit,
        heightSplit,
        2 * widthSplit,
        heightSplit,
      )
      ..lineTo(10 * widthSplit, heightSplit)
      ..quadraticBezierTo(
        11 * widthSplit,
        heightSplit,
        width,
        space,
      )
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BottomBarCustomedPart2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
    final widthSplit = width / 12;
    final heightSplit = height / 4;
    final space = height / 12;

    path
      ..moveTo(0, 0)
      ..quadraticBezierTo(
        widthSplit,
        heightSplit - space,
        2 * widthSplit,
        heightSplit - space,
      )
      ..lineTo(10 * widthSplit, heightSplit - space)
      ..quadraticBezierTo(
        11 * widthSplit,
        heightSplit - space,
        width,
        0,
      )
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
