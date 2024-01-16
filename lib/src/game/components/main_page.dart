import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodiac_night/src/common/app_images.dart';
import 'package:zodiac_night/src/common/widgets/custom_button.dart';
import 'package:zodiac_night/src/common/widgets/custom_icon_button.dart';
import 'package:zodiac_night/src/controllers/settings_controller.dart';
import 'package:zodiac_night/src/game/components/level_page.dart';
import 'package:zodiac_night/src/game/components/rules_page.dart';
import 'package:zodiac_night/src/game/components/settings_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ZnSettingsProvider.watch(context).model;
    final difference = model.dateTime.difference(DateTime.now());
    final myDuration = (const Duration(days: 1) + difference);
    final formattedDuration =
        "${myDuration.inHours}:${(myDuration.inMinutes % 60).toString().padLeft(2, '0')}:${(myDuration.inSeconds % 60).toString().padLeft(2, '0')}";

    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ZnAppImages.mainBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ZnCustomIconButton(
                    icon: ZnAppImages.settings,
                    onPressed: () {
                      return Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ZnSettingsProvider(
                            model: model,
                            child: const ZnSettingsPage(),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 22),
                ],
              ),
              const SizedBox(height: 165),
              ZnCustomButton(
                onPressed: () {
                  if (difference.inDays >= -1) return;
                  showDialog(
                    context: context,
                    builder: (context) => DailyLoginWidget(
                      child: ContentWidget(
                        model: model,
                      ),
                    ),
                  );
                },
                text: (difference.inDays >= -1)
                    ? 'Next Daily Reward in $formattedDuration'
                    : 'Daily Reward',
                buttonType: 'daily',
              ),
              const SizedBox(height: 25),
              ZnCustomButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ZnSettingsProvider(
                      model: model,
                      child: const ZnLevelMap(),
                    ),
                  ),
                ),
                text: 'Play',
              ),
              const SizedBox(height: 25),
              ZnCustomButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ZnRulesPage(),
                  ),
                ),
                text: 'Rules',
              ),
              const SizedBox(height: 108),
            ],
          ),
        ),
      ),
    );
  }
}

class DailyLoginWidget extends StatelessWidget {
  const DailyLoginWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(top: 170.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SizedBox(
            width: 344.w,
            height: 268.h,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.asset(
                  ZnAppImages.dailyLoginDialog,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  top: 45.h,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      color: Colors.black.withAlpha(0),
                      width: 60.w,
                      height: 60.w,
                    ),
                  ),
                ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    super.key,
    required this.model,
  });

  final ZnSettingsController model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 100.h,
      ),
      child: Column(
        children: [
          Text(
            'DAILY\nREWARD',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Campton Bold',
              fontSize: 28.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.w),
            child: Text(
              'Open the gift and find out what you won!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 29.h),
          GestureDetector(
            onTap: () async {
              await model.setDateTime();
              final rand = Random();
              final number = rand.nextInt(3);
              if (!context.mounted) return;
              Navigator.pop(context);
              if (number == 0) {
                print('lose');
                showDialog(
                  context: context,
                  builder: (context) => const DailyLoginWidget(
                    child: WinOrLoseWidget(
                      text: 'TRY AGAIN IN NEXT TIME',
                      image: ZnAppImages.openedChest,
                    ),
                  ),
                );
                return;
              }
              showDialog(
                context: context,
                builder: (context) => const DailyLoginWidget(
                  child: WinOrLoseWidget(
                    text: '20 BONUSES',
                    image: ZnAppImages.dailyMoney,
                  ),
                ),
              );
              await model.setMoney(20);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Image.asset(
                    ZnAppImages.chest,
                    width: 98.w,
                    height: 98.h,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WinOrLoseWidget extends StatelessWidget {
  const WinOrLoseWidget({
    super.key,
    required this.text,
    required this.image,
  });

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: 100.h),
        child: Column(
          children: [
            Text(
              'DAILY\nREWARD',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Campton Bold',
                fontSize: 28.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20.h),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Image.asset(
                  image,
                  width: 250.w,
                  height: 250.h,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
