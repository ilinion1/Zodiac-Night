import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodiac_night/src/common/app_images.dart';
import 'package:zodiac_night/src/common/widgets/outline_text.dart';
import 'package:zodiac_night/src/controllers/settings_controller.dart';

class CustomButtonDefolut extends StatefulWidget {
  const CustomButtonDefolut({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final Function()? onPressed;
  final String text;

  @override
  State createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButtonDefolut> {
  bool isPressed = false;

  void onPressed() {
    final model = SettingsProvider.read(context)?.model;
    if (model?.sound ?? false) {
      AudioPlayer().play(AssetSource('audio/sound_default.wav'));
    }
    isPressed = true;
    setState(() {});
    Future.delayed(const Duration(milliseconds: 150), () {
      isPressed = false;
      if (mounted) setState(() {});
    });
    if (widget.onPressed == null) return;
    widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (_) => setState(() {
        onPressed();
      }),
      onPanDown: (_) => setState(() {
        isPressed = true;
      }),
      // onTap: () => onPressed(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            isPressed ? AppImages.buttonPressed : AppImages.button,
            fit: BoxFit.contain,
            width: 246.w,
            height: 64.h,
          ),
          OutlinedTextDefault(
            text: widget.text,
            textStyle: TextStyle(
              fontFamily: 'Luckiest Guy',
              fontSize: 20.sp,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
