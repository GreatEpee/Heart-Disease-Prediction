import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(15.w, 300.h, 15.w, 25.h),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A1D37), Color(0xFF0F3D6E), Color(0xFF1A5F9C)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  final scale =
                      1 +
                      (_controller.value < 0.5
                          ? _controller.value * 0.3
                          : (1 - _controller.value) * 0.3);
                  return Transform.scale(
                    scale: scale,
                    child: Icon(
                      Icons.favorite,
                      size: 120,
                      color: Colors.redAccent.withAlpha(150),
                    ),
                  );
                },
              ),
              SizedBox(height: 15.h),
              Text(
                'HeartGuard AI',
                style: TextStyle(
                  fontSize: 42.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      blurRadius: 20.r,
                      color: Colors.redAccent.withAlpha(125),
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
              Text(
                'Advanced Machine Learning for Early Heart Disease Detection',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white70,
                  height: 1.5.h,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () => Get.toNamed('homeScreen'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4757),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 10,
                  shadowColor: const Color(0xFFFF4757).withAlpha(150),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Made by Zooha with lots of ',
                    style: TextStyle(fontSize: 14.sp, color: Colors.white60),
                  ),
                  Icon(Icons.favorite, color: Colors.redAccent, size: 18.sp),
                  Text(
                    ' and ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(Icons.coffee, color: Color(0xFFE6B17E), size: 18),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
