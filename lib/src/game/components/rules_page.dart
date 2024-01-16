import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodiac_night/src/common/app_colors.dart';
import 'package:zodiac_night/src/common/app_images.dart';
import 'package:zodiac_night/src/common/widgets/custom_button.dart';
import 'package:zodiac_night/src/common/widgets/money_widget.dart';
import 'package:zodiac_night/src/common/widgets/outline_text.dart';
import 'package:zodiac_night/src/game/components/card_widget.dart';

class ZnRulesPage extends StatelessWidget {
  const ZnRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ZnAppImages.background1),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox.shrink(),
            ZnOutlinedText(
              text: 'RULES',
              strokeWidth: 14,
              textStyle: TextStyle(
                fontSize: 50.sp,
              ),
            ),
            SizedBox(
              width: 334.w,
              child: const ZnOutlinedText(
                text:
                    'You have to collect pairs of elements hidden under the cards',
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ZnCardWidget(
                  value: 13,
                  isFlipped: true,
                  onPressed: () {},
                  color: ZnAppColors.mainColor,
                  isDone: false,
                ),
                const SizedBox(width: 8),
                ZnCardWidget(
                  value: 13,
                  isFlipped: true,
                  onPressed: () {},
                  color: ZnAppColors.mainColor,
                  isDone: false,
                ),
              ],
            ),
            SizedBox(
              width: 273.w,
              child: const ZnOutlinedText(
                text: 'You earn points for every successful combination',
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const ZnScoreWidget(score: 20),
            SizedBox(
              width: 299.w,
              child: const ZnOutlinedText(
                text:
                    'If you fail, you lose your extra hearts. Their offering is limited. When they run out, the game is over',
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ZnAppImages.diamond,
                  width: 46,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 3),
                Image.asset(
                  ZnAppImages.diamond,
                  width: 46,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 3),
                Image.asset(
                  ZnAppImages.diamond,
                  width: 46,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            // const Spacer(),
            ZnCustomButton(
              onPressed: () => Navigator.pop(context),
              text: 'Lobby',
            ),
          ],
        ),
      ),
    );
  }
}
