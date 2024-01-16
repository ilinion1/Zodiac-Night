import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:zodiac_night/src/common/app_images.dart';
import 'package:zodiac_night/src/controllers/settings_controller.dart';

class ZnCustomIconButton extends StatefulWidget {
  const ZnCustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final String icon;
  final Function()? onPressed;

  @override
  State<ZnCustomIconButton> createState() => _ZnCustomIconButtonState();
}

class _ZnCustomIconButtonState extends State<ZnCustomIconButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (_) {
        final model = ZnSettingsProvider.read(context)!.model;
        if (model.sound)
          AudioPlayer().play(AssetSource('audio/sound_default.wav'));
        isPressed = true;
        setState(() {});
        Future.delayed(const Duration(milliseconds: 150), () {
          isPressed = false;
          setState(() {});
        });
        if (widget.onPressed == null) return;
        widget.onPressed!();
      },
      onPanDown: (_) => setState(() {
        isPressed = true;
      }),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            isPressed ? ZnAppImages.iconButtonPressed : ZnAppImages.iconButton,
            width: 64,
            height: 64,
            fit: BoxFit.contain,
          ),
          Image.asset(
            widget.icon,
            width: 38,
            height: 38,
          ),
        ],
      ),
    );
  }
}
