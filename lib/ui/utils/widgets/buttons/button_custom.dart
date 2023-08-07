// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:onboarding_concept/ui/utils/widgets/texts/text.dart';

class AnimationButon extends StatefulWidget {
  final Function onPressed;
  final double shrinkScale;
  final String title;

  final Color? shadow;
  final Color? colorButon;
  final double? width;
  final IconData? icon;
  const AnimationButon({
    Key? key,
    required this.onPressed,
    this.shrinkScale = 0.9,
    required this.title,
    this.shadow,
    this.colorButon,
    this.width,
    this.icon,
  }) : super(key: key);

  @override
  _AnimationButonState createState() => _AnimationButonState();
}

class _AnimationButonState extends State<AnimationButon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward();
        Future.delayed(const Duration(milliseconds: 200), () {
          _controller.reverse();
        });
        widget.onPressed();
      },
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.0,
          end: widget.shrinkScale,
        ).animate(_controller),
        child: Container(
          height: 50,
          width: widget.width,
          decoration: BoxDecoration(color: widget.colorButon ?? Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: const [
            // BoxShadow(color: widget.shadow ?? themeColor, spreadRadius: 1, blurRadius: 8, offset: const Offset(0, 2)),
            // const BoxShadow(color: Colors.white, spreadRadius: 2, blurRadius: 8, offset: Offset(-3, -3))
          ]),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon != null
                  ? Icon(
                      widget.icon,
                      color: Colors.white,
                    )
                  : Container(),
              TextCus(
                title: widget.title,
                color: Colors.white,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
