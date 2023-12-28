import 'package:flutter/material.dart';
import 'package:screw_calc/utility/app_theme.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final Color? color;
  final double fontSize;
  final FontWeight? fontWeight;

  final int? maxLines;
  final double? height;
  final TextAlign? textAlign;
  final bool? underline;

  const CustomText({
    Key? key,
    required this.text,
    this.color = AppColors.white,
    this.fontWeight = FontWeight.normal,
    required this.fontSize,
    this.fontFamily,
    this.textAlign,
    this.height,
    this.underline = false,
    this.maxLines = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      textAlign: textAlign ?? TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        height: height ?? 1.4,
        fontSize: fontSize,
        fontFamily: fontFamily ?? AppFonts.regular,
        color: color,
        decoration: underline! ? TextDecoration.underline : TextDecoration.none,
        decorationColor: color,
        // fontWeight: bold ? AppFonts.w700 : fontWeight,
      ),
      maxLines: maxLines,
    );
  }
}
