import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/utility/app_theme.dart';

class Utilities {
  customSnackBarTerms(BuildContext context, {String? txt}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          text: txt ?? "",
          fontSize: 16.sp,
          color: AppColors.white,
          textAlign: TextAlign.end,
        ),
        // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        backgroundColor: AppColors.mainColor,
      ),
    );
  }
}
