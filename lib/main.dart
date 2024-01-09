import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodiac_night/src/common/app_images.dart';
import 'package:zodiac_night/src/common/widgets/custom_button.dart';
import 'package:zodiac_night/src/controllers/settings_controller.dart';
import 'package:zodiac_night/src/game/components/rules.dart';
import 'package:zodiac_night/src/game/components/settings.dart';
import 'package:zodiac_night/src/game/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ANimPage(),
      ),
    );
  }
}

class ANimPage extends StatefulWidget {
  @override
  State createState() => _MyAnimatedProgressBarState();
}

class _MyAnimatedProgressBarState extends State<ANimPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener(_splsg);
    _progressAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_progressController);
    _progressController.forward();
  }

  void _splsg(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SettingsProvider(
            model: SettController()..initSettings(),
            child: const initaudio(child: MPageTest()),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.splash),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 80.h),
              child: AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF3F0936),
                              Color(0xFF34032D),
                            ],
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: SizedBox(
                            width: double.infinity,
                            height: 30.h,
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.green.shade100,
                              color: Color.lerp(
                                Color(0xFFA9008E),
                                Color(0xFF640555),
                                _progressAnimation.value,
                              ),
                              value: _progressAnimation.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _progressController.removeStatusListener(_splsg);
    _progressController.dispose();
    super.dispose();
  }
}

class MPageTest extends StatelessWidget {
  const MPageTest({Key? key});

  @override
  Widget build(BuildContext context) {
    final model = SettingsProvider.watch(context).model;
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.splash),
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
              const SizedBox(height: 165),
              CustomButtonDefolut(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsProvider(
                      model: model,
                      child: MyGame(level: model.level),
                    ),
                  ),
                ),
                text: 'New Game',
              ),
              const SizedBox(height: 25),
              CustomButtonDefolut(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RulesPageDef(),
                  ),
                ),
                text: 'Rules',
              ),
              const SizedBox(height: 25),
              CustomButtonDefolut(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsProvider(
                      model: model,
                      child: SettingsPageWithState(),
                    ),
                  ),
                ),
                text: 'Settings',
              ),
              const SizedBox(height: 108),
            ],
          ),
        ),
      ),
    );
  }
}

class initaudio extends StatefulWidget {
  const initaudio({Key? key, required this.child});

  final Widget child;

  @override
  State createState() => initaudiostate();
}

class initaudiostate extends State<initaudio> with WidgetsBindingObserver {
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (AppLifecycleState.paused == state) {
      final model = SettingsProvider.read(context)!.model;
      await model.stopAudio();
    } else if (AppLifecycleState.resumed == state) {
      if (SettingsProvider.read(context)!.model.sound) {
        final model = SettingsProvider.read(context)!.model;
        if (model.sound) {
          await model.playAudio();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) async {
        final model = SettingsProvider.read(context)!.model;
        await model.stopAudio();
      },
      child: widget.child,
    );
  }
}
