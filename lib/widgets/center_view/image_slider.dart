import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tabarak_tv/core/utils/app_assets.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> with SingleTickerProviderStateMixin {
  final List<String> imageUrls = [
    kbr1, kbr2, kbr3
  ];

  int _currentIndex = 0;
  late Timer _timer;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _startImageSlider();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startImageSlider() {
    // Initial delay
    Future.delayed(const Duration(seconds: 5), () {
      _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        // Reset the controller and start a new animation
        _controller.reset();
        _controller.forward();
        
        setState(() {
          _currentIndex = (_currentIndex + 1) % imageUrls.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15)
      ),
      height: 250,
      width: double.infinity,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 1500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: Image.asset(
          imageUrls[_currentIndex],
          key: ValueKey<int>(_currentIndex), // Important for AnimatedSwitcher to detect changes
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}