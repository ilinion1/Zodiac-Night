import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:zodiac_night/src/common/app_colors.dart';
import 'package:zodiac_night/src/common/app_images.dart';
import 'package:zodiac_night/src/common/widgets/custom_button.dart';
import 'package:zodiac_night/src/common/widgets/outline_text.dart';
import 'package:zodiac_night/src/controllers/settings_controller.dart';

class SettingsPageWithState extends StatefulWidget {
  const SettingsPageWithState({super.key});

  @override
  State createState() => _SettingsPageWithState();
}

class _SettingsPageWithState extends State<SettingsPageWithState> {
  late int selectedLevel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    selectedLevel = SettingsProvider.watch(context).model.level;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: const Color(0x96150093),
      border: Border.all(color: const Color(0x96150093)),
      borderRadius: BorderRadius.circular(30),
    );
    final model = SettingsProvider.watch(context).model;
    return PopScope(
      canPop: true,
      onPopInvoked: (value) async => await model.setSettings(),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.levelBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox.shrink(),
                const OutlinedTextDefault(
                  text: 'Settings',
                  strokeWidth: 14,
                  textStyle: TextStyle(
                    fontSize: 62,
                  ),
                ),
                Container(
                  height: 124,
                  decoration: decoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedTextDefault(
                        text: 'Sound: ${model.sound ? 'on' : 'off'}',
                        textStyle: const TextStyle(
                          fontSize: 26,
                        ),
                      ),
                      Switch(
                        inactiveTrackColor: Colors.white,
                        inactiveThumbColor: AppColors.secondaryColor,
                        activeTrackColor: AppColors.mainColor,
                        activeColor: const Color(0x6E150093),
                        trackOutlineColor: const MaterialStatePropertyAll(
                          AppColors.secondaryColor,
                        ),
                        value: model.sound,
                        onChanged: (value) async {
                          model.setSound(value);
                          await model.toggleAudio();
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: decoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const OutlinedTextDefault(
                        text: 'Complexity',
                        textStyle: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      button(1, context, model),
                      button(2, context, model),
                      button(3, context, model),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: decoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const OutlinedTextDefault(
                        text: 'Best score',
                        textStyle: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      OutlinedTextDefault(
                        text: '${model.bestScore}',
                        textStyle: const TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButtonDefolut(
                  onPressed: () async {
                    await model.setSettings();
                    if (context.mounted) Navigator.pop(context);
                  },
                  text: 'lobby',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget button(int code, BuildContext context, SettController model) {
    return ElevatedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor:
            model.level == code ? Colors.white : Colors.transparent,
      ),
      onPressed: () {
        final model = SettingsProvider.read(context)!.model;
        if (model.sound) {
          AudioPlayer().play(AssetSource('audio/sound_default.wav'));
        }

        setState(() {
          selectedLevel = code;
        });
        model.setLevel(code);
      },
      child: SizedBox(
        width: 150,
        height: 50,
        child: Center(
          child: OutlinedTextDefault(
            text: 'Level $code',
            strokeWidth: 4,
            textStyle: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
