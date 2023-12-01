import 'package:flutter/material.dart';

class WaveAnimation extends StatefulWidget {
  const WaveAnimation({
    super.key,
    required this.color,
  });
  final Color color;

  @override
  State<WaveAnimation> createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final double maxRadius = 25;
  final int numberOfWaves = 2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(
            progress: _controller.value,
            maxRadius: maxRadius,
            numberOfWaves: numberOfWaves,
            color: color,
          ),
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class WavePainter extends CustomPainter {
  final double progress;
  final double maxRadius;
  final int numberOfWaves;
  final Color color;

  WavePainter({
    required this.progress,
    required this.maxRadius,
    required this.numberOfWaves,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke;

    double radiusStep = maxRadius / numberOfWaves;

    for (int i = 0; i < numberOfWaves; i++) {
      double currentRadius = i * radiusStep;
      double waveRadius = currentRadius + progress * radiusStep;

      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        waveRadius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
