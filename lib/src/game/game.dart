import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodiac_night/src/common/app_images.dart';
import 'package:zodiac_night/src/common/widgets/custom_button.dart';
import 'package:zodiac_night/src/common/widgets/outline_text.dart';
import 'package:zodiac_night/src/controllers/settings_controller.dart';
import 'package:zodiac_night/src/game/components/middle_widget.dart';

enum GameStatus { won, lose, playing }

class MyGame extends StatefulWidget {
  const MyGame({
    super.key,
    required this.level,
  });

  final int level;

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  late int level;

  // comment
  String title = 'CLICK TO START';

  // for check
  int selectedIndex = -1;
  bool? success;
  bool isPause = false;

  // score & lifes
  int score = 0;
  int life = 3;

  // status
  GameStatus status = GameStatus.playing;

  late List<int> type;

  void levelType() {
    type = switch (level) {
      1 => List.generate(4, (index) => index + 1),
      2 => List.generate(12, (index) => index + 1),
      3 => List.generate(12, (index) => index + 1),
      _ => List.generate(4, (index) => index + 1),
    };
  }

  // Card flipped or not
  late List<bool> cardFlips;

  void levelCardFlips() {
    cardFlips = switch (level) {
      1 => List.generate(8, (index) => false),
      2 => List.generate(24, (index) => false),
      3 => List.generate(36, (index) => false),
      _ => List.generate(8, (index) => false),
    };
  }

  // Card flipped & is done
  late List<bool> isDone;

  void levelIsDone() {
    isDone = switch (level) {
      1 => List.generate(8, (index) => false),
      2 => List.generate(24, (index) => false),
      3 => List.generate(36, (index) => false),
      _ => List.generate(8, (index) => false),
    };
  }

  @override
  void initState() {
    super.initState();
    level = widget.level;
    // levelType();
    // init level
    refreshLevel();
  }

  void refreshLevel() {
    levelType();
    levelCardFlips();
    levelIsDone();

    if (level == 3 && type.length <= 12) {
      extendSquare();
    }
    type
      ..addAll(List.from(type))
      ..shuffle();
    showCards();
  }

  void showCards() {
    isPause = true;
    setState(() {});
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      print('flip');
      cardFlips = switch (level) {
        1 => List.generate(8, (index) => true),
        2 => List.generate(24, (index) => true),
        3 => List.generate(36, (index) => true),
        _ => List.generate(8, (index) => true),
      };
      setState(() {});
    });
    setState(() {});
    Future.delayed(Duration(seconds: level + 1), () {
      if (!mounted) return;
      print('flip');
      isPause = false;

      levelCardFlips();
      setState(() {});
    });
  }

  void extendSquare() {
    final extendSquare = List.generate(13, (index) => index + 1);
    extendSquare.shuffle();
    type.addAll(extendSquare.sublist(0, 5));
  }

  // Game Status
  Future<void> isWon() async {
    if (isDone.where((element) => element == false).isNotEmpty) return;
    status = GameStatus.won;
    title = 'Congratulations!';
    setState(() {});
    final model = SettingsProvider.read(context)!.model;
    if (model.bestScore < score) await model.setScore(score);
  }

  Future<void> isLose() async {
    if (life > 0) return;
    status = GameStatus.lose;
    title = 'ooohh...';

    score = 0;
    setState(() {});
    final model = SettingsProvider.read(context)!.model;
    if (model.bestScore < score) await model.setScore(score);
  }

  // Buttons pressed
  void onTryAgainPressed() {
    final model = SettingsProvider.read(context)!.model;
    if (model.sound) AudioPlayer().play(AssetSource('audio/sound_default.wav'));
    level = SettingsProvider.read(context)!.model.level;
    title = 'Click to start';
    selectedIndex = -1;
    success = false;
    isPause = false;
    life = 3;
    status = GameStatus.playing;
    refreshLevel();
    setState(() {});
  }

  void onItemPressed(int itemIndex) {
    final model = SettingsProvider.read(context)!.model;
    if (model.sound) AudioPlayer().play(AssetSource('audio/sound_default.wav'));
    if (isPause || isDone[itemIndex] || selectedIndex == itemIndex) return;
    setState(() {
      cardFlips[itemIndex] = !cardFlips[itemIndex];
    });
    if (selectedIndex == -1) {
      // if item is not selected
      selectedIndex = itemIndex;
      success = null;
    } else if (type[selectedIndex] != type[itemIndex]) {
      // if items isn't same
      success = false;
      isPause = true;
      title = '-1 extra diamond';
      Future.delayed(const Duration(milliseconds: 500), () async {
        isPause = false;
        cardFlips[itemIndex] = false;
        cardFlips[selectedIndex] = false;
        selectedIndex = -1;
        life--;
        setState(() {});
        await isLose();
      });
    } else if (type[selectedIndex] == type[itemIndex]) {
      // if items is same
      final isDoneIndex = selectedIndex;
      selectedIndex = -1;
      success = true;
      isPause = true;
      title = '+30 points';
      score += 30;
      Future.delayed(const Duration(milliseconds: 500), () async {
        isPause = false;
        isDone[isDoneIndex] = true;
        isDone[itemIndex] = true;
        success = null;
        setState(() {});
        await isWon();
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.levelBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          toolbarHeight: 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 144,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: Color(0xFF3C053A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Center(
                      child: OutlinedTextDefault(
                    text: 'Score: $score',
                    textStyle: TextStyle(
                      fontFamily: 'Luckiest Guy',
                      fontSize: 18.sp,
                    ),
                  ))),
              Row(
                children: List.generate(
                  3,
                  (index) => Image.asset(
                    life >= (index + 1)
                        ? AppImages.diamond
                        : AppImages.diamondBack,
                    width: 36,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Image.asset(
                      AppImages.platform,
                      width: 393.w,
                      height: 210.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            AppImages.labelBack,
                            width: 110.w,
                            height: 36.h,
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0.h),
                            child: OutlinedTextDefault(
                              text: 'Level: $level',
                              textStyle: TextStyle(
                                fontFamily: 'Campton Bold',
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Campton Bold',
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.h)
                    ],
                  ),
                ],
              ),
              MiddleWidget(
                status: status,
                type: type,
                cardFlips: cardFlips,
                isDone: isDone,
                success: success,
                level: level,
                onTryAgainPressed: onTryAgainPressed,
                onItemPressed: onItemPressed,
              ),
              CustomButtonDefolut(
                onPressed: () => Navigator.pop(context),
                text: 'LOBBY',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
