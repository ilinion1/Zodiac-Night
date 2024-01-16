import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zodiac_night/src/common/app_images.dart';
import 'package:zodiac_night/src/controllers/settings_controller.dart';

class ZnCustomButton extends StatefulWidget {
  const ZnCustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.buttonType = 'button',
  });

  final Function()? onPressed;
  final String text;
  final String buttonType;

  @override
  State<ZnCustomButton> createState() => _ZnCustomButtonState();
}

class _ZnCustomButtonState extends State<ZnCustomButton> {
  bool isPressed = false;

  void onPressed() {
    final model = ZnSettingsProvider.read(context)?.model;
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
            switch (widget.buttonType) {
              'daily' => isPressed
                  ? ZnAppImages.dailyButtonPressed
                  : ZnAppImages.dailyButton,
              'level' => isPressed
                  ? ZnAppImages.levelButtonPressed
                  : ZnAppImages.levelButton,
              _ => isPressed ? ZnAppImages.buttonPressed : ZnAppImages.button,
            },
            fit: BoxFit.contain,
            width: widget.buttonType == 'daily' ? 276.w : 246.w,
            height: widget.buttonType == 'daily' ? 48.h : 64.h,
          ),
          Text(
            widget.text,
            style: TextStyle(
              fontSize: widget.buttonType == 'daily' ? 14.sp : 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          )
        ],
      ),
    );
  }
}
