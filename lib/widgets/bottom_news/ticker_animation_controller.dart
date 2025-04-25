import 'package:flutter/material.dart';

class TickerAnimationController {
  final ScrollController scrollController;
  final AnimationController animationController;
  late Animation<double> animation;
  final GlobalKey contentKey;

  TickerAnimationController({
    required this.scrollController,
    required this.animationController,
    required this.contentKey,
  }) {
    _setupAnimationListener();
  }

  void _setupAnimationListener() {
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        scrollController.jumpTo(0);
        animationController.reset();
        animationController.forward();
      }
    });
  }

  void setupAnimation() {
    final RenderBox renderBox =
        contentKey.currentContext?.findRenderObject() as RenderBox;
    final double contentWidth = renderBox.size.width;

    animation = Tween<double>(
      begin: 0.0,
      end: contentWidth,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.linearToEaseOut,
    ));

    animation.addListener(() {
      if (scrollController.hasClients) {
        scrollController.jumpTo(animation.value);
      }
    });

    animationController.forward();
  }

  void dispose() {
    scrollController.dispose();
    animationController.dispose();
  }
}
