import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/constant/colors.dart';
import 'package:to_do/features/splash/provider/app_splash_notifier.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _scaleAnimation = Tween<double>(begin: 0.2, end: 1.0)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutBack,
          ),
        );
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 500), () {
          if (mounted) {
            ref
                .read(appSplashNotifierProvider.notifier)
                .updateSplashStatus(true);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              gradientStart,
              gradientMiddle,
              gradientEnd,
            ],
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Icon(
              Icons.task_rounded,
              size: 120,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 15.5,
                  offset: Offset(6.5, 5.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
