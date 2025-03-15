import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screw_calc/components/custom_button.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/utility/app_theme.dart';

class DashBoardAppBar extends PreferredSize {
  final bool fromHistory;
  final Function? onPressed;

  const DashBoardAppBar({
    super.key,
    required this.fromHistory,
    this.onPressed,
  }) : super(
          child: const SizedBox(),
          preferredSize: const Size.fromHeight(80),
        );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.grayy,
      leading: !fromHistory
          ? IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => Dialog(
                          backgroundColor: AppColors.bg,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 32),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: "تحذير",
                                  fontSize: 18.sp,
                                  color: AppColors.mainColor,
                                ),
                                const SizedBox(height: 40),
                                CustomText(
                                  text: "هل تريد اعادة بدأ الجولة",
                                  fontSize: 18.sp,
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const CustomText(
                                          text: "لا", fontSize: 18),
                                    ),
                                    CustomButton(
                                      width: 0.25.sw,
                                      height: 40,
                                      text: "نعم",
                                      isButtonBorder: true,
                                      onPressed: onPressed,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
              },
              icon: const Icon(Icons.refresh, color: AppColors.white),
            )
          : const SizedBox(),
      actions: [
        IconButton(
          onPressed: () => Navigator.pop(context, true),
          icon: Transform.flip(
            flipX: true,
            child: const Icon(Icons.arrow_back_ios, color: AppColors.white),
          ),
        ),
      ],
      title: CustomText(text: "النتائج", fontSize: 22.sp),
    );
  }
}
