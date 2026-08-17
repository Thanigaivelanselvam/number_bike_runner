import 'package:flutter/material.dart';

class PerspectiveRoadPainter extends CustomPainter {
  final double animation;
  final double cameraX;

  PerspectiveRoadPainter({
    required this.animation,
    required this.cameraX,
  });

  @override
  void paint(
      Canvas canvas,
      Size size,
      ) {
    final center =
        size.width / 2 +
            cameraX * size.width;

    // Road
    final road = Path();

    road.moveTo(
      center - 45,
      size.height * .42,
    );

    road.lineTo(
      center + 45,
      size.height * .42,
    );

    road.lineTo(
      size.width * .95,
      size.height,
    );

    road.lineTo(
      size.width * .05,
      size.height,
    );

    road.close();

    final roadPaint = Paint()
      ..color = const Color(0xFF343434);

    canvas.drawPath(
      road,
      roadPaint,
    );

    // Yellow road edges
    final edge = Paint()
      ..color = const Color(0xFFFFD54F)
      ..strokeWidth = 5;

    canvas.drawLine(
      Offset(
        center - 45,
        size.height * .42,
      ),
      Offset(
        size.width * .05,
        size.height,
      ),
      edge,
    );

    canvas.drawLine(
      Offset(
        center + 45,
        size.height * .42,
      ),
      Offset(
        size.width * .95,
        size.height,
      ),
      edge,
    );

    // Center lane
    final lane = Paint()
      ..color = Colors.white
      ..strokeWidth = 5;

    for (int i = 0; i < 12; i++) {
      final t =
          ((i / 12) + animation) % 1;

      final y =
          size.height * .43 +
              t * size.height * .57;

      final width =
          5 + t * 30;

      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(
            center,
            y,
          ),
          width: width,
          height: 10 + t * 35,
        ),
        lane,
      );
    }
  }

  @override
  bool shouldRepaint(
      covariant PerspectiveRoadPainter oldDelegate,
      ) {
    return true;
  }
}