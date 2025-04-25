import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_texts.dart';
import '../../core/utils/app_textstyles.dart';
// import 'package:pulparambil_gold/app/core/utils/app_colors.dart';
// import 'package:pulparambil_gold/app/core/utils/app_texts.dart';
// import 'package:pulparambil_gold/app/core/utils/app_textstyles.dart';

class TickerWidget extends StatefulWidget {
  final String combinedHeadlines;
  final double height;
  
  const TickerWidget({
    super.key,
    required this.combinedHeadlines,
    required this.height,
  });

  @override
  State<TickerWidget> createState() => _TickerWidgetState();
}

class _TickerWidgetState extends State<TickerWidget> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late double _contentWidth;
  final GlobalKey _contentKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    
    WidgetsBinding.instance.addPostFrameCallback((_) => _setupAnimation());
    
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scrollController.jumpTo(0);
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  void _setupAnimation() {
    final RenderBox renderBox = _contentKey.currentContext?.findRenderObject() as RenderBox;
    _contentWidth = renderBox.size.width;
    
    _animation = Tween<double>(
      begin: 0.0,
      end: _contentWidth,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linearToEaseOut,
    ));
    
    _animation.addListener(() {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_animation.value);
      }
    });
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
borderRadius: BorderRadius.circular(15),
      color: kCaccent1,
      ),
      height: widget.height,
      child: Row(
        children: [
          // Left side - PULPARAMBIL NEWS
          _buildTitleSection(),
          // Right side - Scrolling news
          _buildScrollingNewsSection(),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Container(
      width: 230,
      decoration: BoxDecoration(
borderRadius: BorderRadius.circular(15), 
      color: kCaccent2, // Gold color
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        knewsbar,
        style: kSnewsBar,
      ),
    );
  }

  Widget _buildScrollingNewsSection() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          key: _contentKey,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                widget.combinedHeadlines,
                style: kSnewsHedline,
              ),
              const SizedBox(width: 150),
            ],
          ),
        ),
      ),
    );
  }
}