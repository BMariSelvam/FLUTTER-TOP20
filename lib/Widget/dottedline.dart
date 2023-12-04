import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double dotSpacing;
  final double dotWidth;

  DottedLinePainter({
    this.strokeWidth = 1.0,
    this.color = Colors.black,
    this.dotSpacing = 4.0,
    this.dotWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double startX = 0;
    final double endX = size.width;

    for (double x = startX; x < endX; x += dotSpacing + dotWidth) {
      canvas.drawLine(
        Offset(x, size.height / 2),
        Offset(x + dotWidth, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(DottedLinePainter oldDelegate) => false;
}

class DottedHorizontalLine extends StatelessWidget {
  final double height;
  final double width; // New property for specifying the width of the line
  final Color color;
  final double dotSpacing;
  final double dotWidth;

  DottedHorizontalLine({
    this.height = 1.0,
    this.width = double.infinity, // Set a default width to fill the container
    this.color = Colors.black,
    this.dotSpacing = 4.0,
    this.dotWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CustomPaint(
        painter: DottedLinePainter(
          strokeWidth: height,
          color: color,
          dotSpacing: dotSpacing,
          dotWidth: dotWidth,
        ),
      ),
    );
  }
}
