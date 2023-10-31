import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/utility/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? horizontalPadding;
  final Function? onPressed;
  final double? fontSize;
  final String? fontFamily;
  final Color? color;
  final Color? colorFont;
  final bool isButtonBorder;
  final bool isSecondButton;

  final Color? borderColor;

  const CustomButton({
    Key? key,
    this.height,
    this.width,
    this.onPressed,
    this.horizontalPadding,
    this.fontSize,
    this.fontFamily,
    required this.text,
    this.colorFont,
    this.borderRadius,
    this.isButtonBorder = false,
    this.isSecondButton = false,
    this.color,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 52,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 12.sp),
        color: isSecondButton
            ? AppColors.secondaryColorOpacity
            : isButtonBorder
                ? Colors.transparent
                : color ?? AppColors.mainColor,
        border: isButtonBorder
            ? Border.all(
                color: borderColor == null
                    ? AppColors.secondaryColor
                    : borderColor!,
                width: 1)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.sp),
          onTap: () =>
              onPressed == null ? Navigator.pop(context) : onPressed!(),
          child: Center(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: horizontalPadding ?? 4.0),
              child: CustomText(
                text: text,
                fontSize: fontSize ?? 20.sp,
                fontFamily: isSecondButton
                    ? fontFamily == AppFonts.regular
                        ? AppFonts.regular
                        : AppFonts.bold
                    : fontFamily ?? AppFonts.regular,
                fontWeight: AppFonts.w400,
                height: 1,
                //  .8.h,
                color: isSecondButton
                    ? AppColors.secondaryColor
                    : colorFont ?? Colors.white,
                maxLines: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
