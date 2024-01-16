import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodiac_night/src/common/app_images.dart';
import 'package:zodiac_night/src/common/widgets/custom_button.dart';
import 'package:zodiac_night/src/common/widgets/outline_text.dart';
import 'package:zodiac_night/src/controllers/settings_controller.dart';
import 'package:zodiac_night/src/game/game.dart';

const colorFilterMatrix = ColorFilter.matrix(<double>[
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0,
  0,
  0,
  1,
  0
]);

class ZnLevelMap extends StatefulWidget {
  const ZnLevelMap({super.key});

  @override
  State<ZnLevelMap> createState() => _ZnLevelMapState();
}

class _ZnLevelMapState extends State<ZnLevelMap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final images = <String>[
      'assets/images/z11.png',
      'assets/images/z10.png',
      'assets/images/z12.png',
      'assets/images/z1.png',
      'assets/images/z13.png',
      'assets/images/z7.png',
    ];
    final moneys = <int?>[
      60,
      50,
      80,
      120,
      150,
      220,
    ];
    final level = ZnSettingsProvider.watch(context).model.level;
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ZnAppImages.background1),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60.h),
                ZnOutlinedText(
                  text: 'LEVELS',
                  strokeWidth: 14,
                  textStyle: TextStyle(
                    fontSize: 50.sp,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.w,
                      mainAxisExtent: 167.h,
                      mainAxisSpacing: 20.h,
                      childAspectRatio: 173 / 167,
                    ),
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      if (level > index + 1) {
                        return LevelWidget(
                          type: 'skiped',
                          levelIndex: index + 1,
                          money: moneys[index],
                          currentIndex: level,
                          image: images[index],
                        );
                      } else if (level != index + 1) {
                        return LevelWidget(
                          type: 'closed',
                          levelIndex: index + 1,
                          money: moneys[index],
                          currentIndex: level,
                          image: images[index],
                        );
                      }
                      return LevelWidget(
                        type: 'opened',
                        levelIndex: index + 1,
                        money: moneys[index],
                        currentIndex: level,
                        image: images[index],
                      );

                      // return LevelWidget(
                      //   index: index,
                      //   level: level,
                      //   images: images,
                      //   moneys: moneys,
                      // );
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                ZnCustomButton(
                  onPressed: () => Navigator.pop(context),
                  text: 'Lobby',
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LevelWidget extends StatelessWidget {
  const LevelWidget({
    super.key,
    required this.type,
    required this.levelIndex,
    required this.money,
    required this.currentIndex,
    required this.image,
  });

  final String type;
  final int levelIndex;
  final int? money;
  final int currentIndex;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final model = ZnSettingsProvider.read(context)!.model;
        if (levelIndex == currentIndex) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ZnSettingsProvider(
                model: model,
                child: ZnMyGame(level: levelIndex),
              ),
            ),
          );
        } else if (levelIndex == currentIndex + 1) {
          showDialog(
            context: context,
            builder: (builder) {
              return CustomAlertDialog(
                image: image,
                type: type,
                levelText: '${currentIndex + 1}',
                amount: money ?? 0,
                model: model,
              );
            },
          );
        }
      },
      child: Container(
        width: 173.w,
        height: 163.h,
        decoration: BoxDecoration(
          color: levelIndex == currentIndex
              ? const Color(0xFF10036E)
              : levelIndex < currentIndex
                  ? const Color(0xFF181050)
                  : const Color(0xFF464454),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          child: Column(
            children: [
              ColorFiltered(
                colorFilter: levelIndex == currentIndex
                    ? const ColorFilter.mode(
                        Colors.transparent,
                        BlendMode.multiply,
                      )
                    : colorFilterMatrix,
                child: Image.asset(
                  image,
                  width: 66.w,
                  height: 66.h,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Level $levelIndex',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                levelIndex == 1
                    ? 'Free'
                    : type == 'opened' || type == 'skiped'
                        ? 'Open'
                        : '$money points',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.image,
    required this.type,
    required this.levelText,
    required this.amount,
    required this.model,
  });

  final String image;
  final String type;
  final String levelText;
  final int amount;
  final ZnSettingsController model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 158.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SizedBox(
          width: 344.w,
          height: 268.h,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Image.asset(
                ZnAppImages.openedLevelDialog,
                fit: BoxFit.contain,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  color: Colors.black.withAlpha(0),
                  width: 60.w,
                  height: 60.w,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    Text(
                      type == 'opened' ? 'LEVEL\nOPENED' : 'OPEN\nLEVEL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Campton Bold',
                        fontSize: 30.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 17.h),
                    ColorFiltered(
                      colorFilter: type == 'opened'
                          ? const ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.multiply,
                            )
                          : colorFilterMatrix,
                      child: Image.asset(
                        image,
                        width: 66.w,
                        height: 66.h,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.w),
                      child: Text(
                        'Level $levelText',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (type != 'opened')
                      Text(
                        'NEED $amount POINTS',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    SizedBox(height: 14.h),
                    ZnCustomButton(
                      onPressed: () async {
                        if (type == 'opened') {
                          Navigator.pop(context);
                        } else {
                          if (model.money - amount < 0) return;
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => CustomAlertDialog(
                              image: image,
                              type: 'opened',
                              levelText: levelText,
                              amount: 0,
                              model: model,
                            ),
                          );
                          await model.setLevel(int.parse(levelText));
                          await model.setMoney(-amount);
                        }
                      },
                      text: type == 'opened' ? 'OK' : 'OPEN',
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
