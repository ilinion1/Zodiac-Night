import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodiac_night/src/common/app_images.dart';
import 'package:zodiac_night/src/common/widgets/custom_button.dart';
import 'package:zodiac_night/src/common/widgets/outline_text.dart';

class RulesPageDef extends StatelessWidget {
  const RulesPageDef({super.key});

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox.shrink(),
            const OutlinedTextDefault(
              text: 'rules',
              textStyle: TextStyle(
                fontSize: 48,
              ),
            ),
            const SizedBox(
              width: 236,
              child: OutlinedTextDefault(
                text:
                    'You have to collect pairs of elements hidden under the cards',
                textStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: Container(
                    padding: EdgeInsets.all(0.w),
                    width: 60.0.w,
                    height: 60.0.w,
                    decoration: BoxDecoration(
                        border: Border.all(

                          width: 2,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.purple,
                            Colors.blue[900]!,
                          ],
                        )),
                    // color: isFlipped ? Colors.blue : Colors.grey,
                    child: Image.asset(
                      'assets/images/el14.png',
                      width: 40.w,
                      height: 40.h,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: Container(
                    padding: EdgeInsets.all(0.w),
                    width: 60.0.w,
                    height: 60.0.w,
                    decoration: BoxDecoration(
                        border: Border.all(

                          width: 2,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.purple,
                            Colors.blue[900]!,
                          ],
                        )),
                    // color: isFlipped ? Colors.blue : Colors.grey,
                    child: Image.asset(
                      'assets/images/el14.png',
                      width: 40.w,
                      height: 40.h,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 278,
              child: OutlinedTextDefault(
                text: 'You earn points for every successful combination',
                textStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const OutlinedTextDefault(
              text: 'Score: 10',
              textStyle: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              width: 302,
              child: OutlinedTextDefault(
                text:
                    'If you fail, you lose your extra hearts. Their offering is limited. When they run out, the game is over',
                textStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.diamond,
                  width: 46,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 3),
                Image.asset(
                  AppImages.diamond,
                  width: 46,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 3),
                Image.asset(
                  AppImages.diamond,
                  width: 46,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            CustomButtonDefolut(
              onPressed: () => Navigator.pop(context),
              text: 'lobby',
            ),
          ],
        ),
      ),
    );
  }
}
