import 'package:flutter/material.dart';
import 'package:zodiac_night/src/common/widgets/custom_button.dart';
import 'package:zodiac_night/src/common/widgets/outline_text.dart';
import 'package:zodiac_night/src/controllers/settings_controller.dart';
import 'package:zodiac_night/src/game/levels/level1.dart';
import 'package:zodiac_night/src/game/levels/level2.dart';
import 'package:zodiac_night/src/game/game.dart';

import '../levels/level3.dart';

class MiddleWidget extends StatelessWidget {
  const MiddleWidget({
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

  final GameStatus status;
  final List<int> type;
  final List<bool> cardFlips;
  final List<bool> isDone;
  final bool? success;
  final int level;
  final Function(int) onItemPressed;
  final Function() onTryAgainPressed;

  Widget playingWidget() {
    return switch (level) {
      1 => Level1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) => onItemPressed(itemIndex),
        ),
      2 => Level2(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) => onItemPressed(itemIndex),
        ),
      3 => Level3(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) => onItemPressed(itemIndex),
        ),
      _ => Level1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) => onItemPressed(itemIndex),
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      GameStatus.playing => playingWidget(),
      GameStatus.lose => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Column(
              children: [
                OutlinedTextDefault(
                  text: 'GAME OVER',
                  strokeWidth: 8,
                  textStyle: TextStyle(
                    fontSize: 48,
                  ),
                ),
                OutlinedTextDefault(
                  text: 'try your luck again!',
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CustomButtonDefolut(
              onPressed: onTryAgainPressed,
              text: 'Try again',
            ),
            const SizedBox(height: 22),
          ],
        ),
      GameStatus.won => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const OutlinedTextDefault(
              text: 'Big win!',
              strokeWidth: 8,
              textStyle: TextStyle(
                fontSize: 48,
              ),
            ),
            const SizedBox(
              width: 236,
              child: OutlinedTextDefault(
                text: 'You managed to collect all the pairs!',
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            CustomButtonDefolut(
              onPressed: () async {
                final model = SettingsProvider.read(context)!.model;
                model.setLevel(level % 3 + 1);
                await model.setSettings();
                onTryAgainPressed();
              },
              text: 'Next level',
            ),
            const SizedBox(height: 10),
            CustomButtonDefolut(
              onPressed: onTryAgainPressed,
              text: 'Try again',
            ),
            const SizedBox(height: 22),
          ],
        ),
    };
  }
}
