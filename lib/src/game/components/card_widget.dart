import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWidget extends StatefulWidget {
  final int value;
  final bool isFlipped;
  final Function onPressed;
  final Color color;
  final bool isDone;

  const CardWidget({
    super.key,
    required this.value,
    required this.isFlipped,
    required this.onPressed,
    required this.color,
    required this.isDone,
  });

  @override
  State<CardWidget> createState() => _CardFlipperState();
}

class _CardFlipperState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isFront = true;
  bool _isFlipping = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CardWidget oldWidget) {
    if (widget.isFlipped != oldWidget.isFlipped) {
      if (_isFlipping || widget.isDone) return;
      if (_isFront) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      _isFlipping = true;
      Future.delayed(const Duration(milliseconds: 150), () {
        if (!mounted) return;
        _isFront = !_isFront;
        _isFlipping = false;
        setState(() {});
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final angle = _controller.value * pi;
          final frontOpacity = _isFront ? 1.0 : 0.0;
          final backOpacity = _isFront ? 0.0 : 1.0;

          return ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.all(1.w),
              child: Stack(
                children: [
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle),
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: frontOpacity,
                      child: const FrontCard(),
                    ),
                  ),
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle + pi),
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: backOpacity,
                      child: BackCard(
                        isDone: widget.isDone,
                        color: widget.color,
                        value: widget.value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FrontCard extends StatelessWidget {
  const FrontCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(0.5.h),
      width: 60.0.w,
      height: 60.0.w,
      color: Colors.grey,
      child: Image.asset(
        'assets/images/closed.png',
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

class BackCard extends StatelessWidget {
  const BackCard({
    super.key,
    required this.isDone,
    required this.color,
    required this.value,
  });

  final bool isDone;
  final Color color;
  final int value;

  @override
  Widget build(BuildContext context) {
    return (isDone)
        ? Container(
            padding: EdgeInsets.all(0.5.w),
            width: 60.0.w,
            height: 60.0.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Image.asset(
              'assets/images/opened.png',
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: Container(
              padding: EdgeInsets.all(5.w),
              width: 60.0.w,
              height: 60.0.w,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: color,
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
                'assets/images/el$value.png',
                width: 40.w,
                height: 40.h,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          );
  }
}
