import 'dart:math' as math;

import 'package:flutter/material.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Container(
            //   width: 400,
            //   height: 400,
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).colorScheme.error.withOpacity(0.8),
            //     borderRadius: BorderRadius.circular(116),
            //   ),
            // ),
            CustomPaint(
              size: const Size(320, 320),
              painter: SuperellipsePainter(
                3,
                color: Theme.of(context).colorScheme.primary,
                shadowBlurRadius: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuperellipsePainter extends CustomPainter {
  final double n;
  final Color? color;
  final Color? shadowColor;
  final double shadowBlurRadius;

  SuperellipsePainter(
    this.n, {
    this.color = Colors.blue,
    this.shadowColor = Colors.black,
    this.shadowBlurRadius = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    const int points = 100;
    // 0による除算を避けるためにepsilonを加える
    const epsilon = 1e-10;
    for (int i = 0; i <= points; i++) {
      final angle = (i / points) * 2 * math.pi;
      final cosAngle = math.cos(angle);
      final sinAngle = math.sin(angle);
      final x = math.pow(cosAngle.abs() + epsilon, 2 / n) *
              size.width /
              2 *
              (cosAngle < 0 ? -1 : 1) +
          size.width / 2;
      final y = math.pow(sinAngle.abs() + epsilon, 2 / n) *
              size.height /
              2 *
              (sinAngle < 0 ? -1 : 1) +
          size.height / 2;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // 影を描画
    canvas.drawShadow(path, shadowColor!, shadowBlurRadius, true);

    // スーパー楕円のパスを塗りつぶしで描画
    final paint = Paint()
      ..color = color!
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
