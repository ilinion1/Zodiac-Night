import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodiac_night/src/common/widgets/custom_button.dart';
import 'package:zodiac_night/src/common/widgets/outline_text.dart';
import 'package:zodiac_night/src/game/components/levels/level1.dart';
import 'package:zodiac_night/src/game/components/levels/level3.dart';
import 'package:zodiac_night/src/game/game.dart';

class ZnMiddleWidget extends StatelessWidget {
  const ZnMiddleWidget({
    super.key,
    required this.status,
    required this.type,
    required this.cardFlips,
    required this.isDone,
    required this.success,
    required this.level,
    required this.onTryAgainPressed,
    required this.onItemPressed,
  });

  final ZnGameStatus status;
  final List<int> type;
  final List<bool> cardFlips;
  final List<bool> isDone;
  final bool? success;
  final int level;
  final Function(int) onItemPressed;
  final Function() onTryAgainPressed;

  Widget playingWidget() {
    return switch (level) {
      1 => ZnLevel1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      2 => ZnLevel1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      3 => ZnLevel1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      4 => ZnLevel1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      5 => ZnLevel3(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      6 => ZnLevel3(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      _ => ZnLevel1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      ZnGameStatus.playing => playingWidget(),
      ZnGameStatus.lose => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Column(
              children: [
                ZnOutlinedText(
                  strokeWidth: 10,
                  text: 'Game over',
                  textStyle: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ZnOutlinedText(
                  text: 'Please Try  Your \nLuck Again',
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ZnCustomButton(
              onPressed: onTryAgainPressed,
              text: 'RESTART',
            ),
            const SizedBox(height: 22),
          ],
        ),
      ZnGameStatus.won => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ZnOutlinedText(
              strokeWidth: 10,
              text: 'Big win!',
              textStyle: TextStyle(
                fontSize: 48.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.w),
              child: ZnOutlinedText(
                text: 'You managed to collect all the pairs!',
                textStyle: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ZnCustomButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              text: 'TO NEXT LEVEL',
            ),
            const SizedBox(height: 10),
            ZnCustomButton(
              onPressed: onTryAgainPressed,
              text: 'RESTART',
            ),
            const SizedBox(height: 22),
          ],
        ),
    };
  }
}
