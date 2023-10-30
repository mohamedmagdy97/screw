import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screw_calc/utility/app_theme.dart';

getBoxDecoration({
  Color? color,
  double? radiusBottom,
  double? spreadRadius,
  double? blurRadius,
}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radiusBottom ?? 12.sp),
  /*boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: spreadRadius ?? .1,
        blurRadius: blurRadius ?? 0.1,
      ),
    ],*/
    color: color ?? AppColors.mainColor,
  );
}
