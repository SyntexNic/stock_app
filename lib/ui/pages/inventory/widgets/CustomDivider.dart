import 'package:flutter/material.dart';
import 'package:stock_app/constants/Theme.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final Color color;
  final EdgeInsetsGeometry padding;

  CustomDivider(
      {this.height = 1.0, this.color = Colors.grey, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: CustomPaint(
        painter: _CustomDividerPainter(color),
        child: SizedBox(height: height),
      ),
    );
  }
}

class _CustomDividerPainter extends CustomPainter {
  final Color color;

  _CustomDividerPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.square;

    final startPoint = Offset(0, size.height / 2);
    final endPoint = Offset(size.width, size.height / 2);

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(_CustomDividerPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
