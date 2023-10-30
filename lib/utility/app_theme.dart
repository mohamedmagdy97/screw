import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'app_colors.dart';

part 'app_fonts.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.mainColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.white),
  appBarTheme: AppBarTheme(
      centerTitle: true,
      color: AppColors.white,
      elevation: 0,
      titleTextStyle:
          TextStyle(color: AppColors.secondaryColor, fontSize: 20.sp)),
);

class AppStyle {
  static LinearGradient bgLinearGradientGray() {
    return const LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [
          Color.fromRGBO(90, 91, 92, 1.0),
          Color.fromRGBO(90, 91, 92, 1.0),
        ]);
  }

  static LinearGradient bgLinearGradientBrand() {
    return const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromRGBO(192, 0, 111, 1),
          Color.fromRGBO(255, 14, 157, 1)
        ]);
  }

  static LinearGradient bgLinearGradientBrandDrawerBt() {
    return const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Color.fromRGBO(192, 0, 111, 1),
          Color.fromRGBO(255, 14, 157, 1)
        ]);
  }

  static LinearGradient bgLinearGradientDrawer() {
    return const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.center,
        stops: [
          0.0,
          0.6
        ],
        colors: [
          Color.fromRGBO(0, 0, 0, 0.03),
          Color.fromRGBO(0, 0, 0, 0),
        ]);
  }

  static LinearGradient bgLinearGradientLoader() {
    return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(1, 6, 0, 0.15),
          Color.fromRGBO(0, 0, 0, 0),
        ]);
  }

  static LinearGradient bgLinearGradientBrand2() {
    return const LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [
          Color.fromRGBO(192, 0, 111, 1),
          Color.fromRGBO(255, 14, 157, 1)
        ]);
  }

  static get whiteGradient {
    return const LinearGradient(colors: [
      Colors.white,
      Colors.white,
    ]);
  }
}
