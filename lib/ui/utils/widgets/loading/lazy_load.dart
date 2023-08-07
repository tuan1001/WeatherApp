import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ShowLoading extends StatefulWidget {
  const ShowLoading({Key? key});

  @override
  State<ShowLoading> createState() => _ShowLoadingState();
}

class _ShowLoadingState extends State<ShowLoading> with SingleTickerProviderStateMixin {
  late Animation<double> opacity = Tween<double>(begin: 1, end: 0.4).animate(animController)
    ..addListener(() {
      setState(() {});
    });
  late AnimationController animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
  @override
  void initState() {
    animController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: opacity.value,
            child: const ModalBarrier(dismissible: false, color: Colors.black),
          ),
          LoadingAnimationWidget.horizontalRotatingDots(color: Colors.white, size: 40),
        ],
      ),
    );
  }
}
