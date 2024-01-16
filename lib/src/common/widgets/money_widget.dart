import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodiac_night/src/common/app_colors.dart';

class ZnScoreWidget extends StatelessWidget {
  const ZnScoreWidget({
    super.key,
    required this.score,
    this.isClosed = false,
  });

  final int score;
  final bool isClosed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.h,
      width: 154.w,
      decoration: BoxDecoration(
        color: ZnAppColors.secondaryColor,
        borderRadius: BorderRadius.circular(34.r),
      ),
      child: Center(
        child: Text(
          'SCORE: $score',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
