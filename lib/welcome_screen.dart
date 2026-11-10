import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:findjob/job_selection_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<Offset> _topAnimation;
  late final Animation<Offset> _rightAnimation;
  late final Animation<Offset> _leftAnimation;
  late final Animation<Offset> _textAnimation;
  late final Animation<double> _opacityAnimation;

  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    _initializeAnimations();
    _controller.addStatusListener(_handleAnimationStatus);
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _opacityAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(_controller);

    _topAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(_controller);

    _rightAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, 0),
    ).animate(_controller);

    _leftAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0),
    ).animate(_controller);

    _textAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.50),
    ).animate(_controller);
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && !_hasNavigated) {
      _navigateToJobSelectionScreen();
    }
  }

  void _navigateToJobSelectionScreen() {
    _hasNavigated = true;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JobSelectionScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_handleAnimationStatus);
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1214),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Stack(
              children: [
                Positioned(
                  right: -15,
                  bottom: 3.h,
                  child: SlideTransition(
                    position: _rightAnimation,
                    child: SizedBox(
                      width: 60.w,
                      height: 40.h,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/a3.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: -10.h,
                  child: SlideTransition(
                    position: _topAnimation,
                    child: SizedBox(
                      width: 50.w,
                      height: 40.h,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: const Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/a1.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 13.h,
                  left: -20,
                  child: SlideTransition(
                    position: _leftAnimation,
                    child: SizedBox(
                      width: 60.w,
                      height: 40.h,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: const Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/a2.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SlideTransition(
              position: _textAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Text(
                  'the new era \n of recruitment',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 29.50.sp,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: SlideTransition(
              position: _textAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: const Text(
                  'find your best job or create vacancies and look for\nnew colleagues right here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white38,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => _controller.forward(),
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                    left: 5,
                    right: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.w),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'get start',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
