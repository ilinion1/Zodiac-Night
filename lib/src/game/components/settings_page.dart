import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodiac_night/src/common/app_colors.dart';
import 'package:zodiac_night/src/common/app_images.dart';
import 'package:zodiac_night/src/common/widgets/custom_button.dart';
import 'package:zodiac_night/src/common/widgets/outline_text.dart';
import 'package:zodiac_night/src/controllers/settings_controller.dart';

class ZnSettingsPage extends StatelessWidget {
  const ZnSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: ZnAppColors.settingsBack,
      borderRadius: BorderRadius.circular(20.r),
    );
    final model = ZnSettingsProvider.watch(context).model;
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ZnAppImages.background1),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black45,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            children: [
              SizedBox(height: 68.h),
              ZnOutlinedText(
                text: 'SETTINGS',
                strokeWidth: 14,
                textStyle: TextStyle(
                  fontSize: 50.sp,
                ),
              ),
              SizedBox(height: 53.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                height: 124.h,
                decoration: decoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ZnOutlinedText(
                      text: 'Sound: ${model.sound ? 'ON' : 'OFF'}',
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Switch(
                      inactiveTrackColor: Colors.white70,
                      inactiveThumbColor: Colors.white,
                      activeTrackColor: Colors.purple.shade900,
                      activeColor: Colors.purple,
                      trackOutlineColor: const MaterialStatePropertyAll(
                        ZnAppColors.secondaryColor,
                      ),
                      value: model.sound,
                      onChanged: (value) async {
                        await model.setSound(value);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                height: 107.h,
                width: double.infinity,
                decoration: decoration,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZnOutlinedText(
                      text: 'Best Score: ${model.score}',
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                height: 107.h,
                width: double.infinity,
                decoration: decoration,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZnOutlinedText(
                      text: 'Points: ${model.money}',
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              ZnCustomButton(
                onPressed: () => Navigator.pop(context),
                text: 'Lobby',
              ),
              SizedBox(height: 64.h),
            ],
          ),
        ),
      ),
    );
  }
}
