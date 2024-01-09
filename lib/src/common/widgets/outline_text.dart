import 'package:flutter/material.dart';
import 'package:zodiac_night/src/common/app_colors.dart';

class OutlinedTextDefault extends StatelessWidget {
  const OutlinedTextDefault({
    super.key,
    required this.text,
    required this.textStyle,
    this.strokeWidth = 5,
  });

  final String text;
  final TextStyle textStyle;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text.toUpperCase(),
          textAlign: TextAlign.center,
          style: textStyle.merge(
            TextStyle(
              letterSpacing: 1,
              fontFamily: 'Campton Bold',
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeCap = StrokeCap.round
                ..strokeWidth = strokeWidth
                ..color = AppColors.mainColor,
            ),
          ),
        ),
        Text(
          text.toUpperCase(),
          textAlign: TextAlign.center,
          style: textStyle.merge(
            const TextStyle(
              letterSpacing: 1,
              fontFamily: 'Campton Bold',
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
