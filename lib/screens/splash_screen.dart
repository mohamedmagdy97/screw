import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/screens/game_mode/game_mode.dart';
import 'package:screw_calc/screens/home/home.dart';
import 'package:screw_calc/utility/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> getNextPage() async {
    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const GameMode()),
          (route) => false);
    });
  }

  @override
  void initState() {
    getNextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80.h),
            Padding(
              padding: EdgeInsets.all(24.sp),
              child: Image.asset("assets/icons/icon.png", height: 0.15.sh),
            ),
            SizedBox(
              height: 25.h,
            ),
            const CustomText(text: "صلي على النبي", fontSize: 16),
          ],
        ),
      ),
    );
  }
}
