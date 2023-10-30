import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screw_calc/utility/validation_form.dart';

import '../../utility/app_theme.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final TextInputType inputType;
  final String labelText;
  final String hintText;
  final TextFieldValidatorType? textFieldVaidType;
  final TextEditingController controller;
  TextEditingController? confirmPasswordController;
  final String? firstPasswordToConfirm;
  double containtPaddingRight;
  bool obscureText;
  int? maxLength;
  int? maxLines;
  int? maxerrorLines;
  bool isDisable = false;
  double? borderRadius;
  double? iconDataHeight;
  double? iconDataWidth;
  double? hintFontSize;

  final String? prefixIcon;
  final String? suffixIcon;
  final GestureTapCallback? onTapSuffix;

  final Color? fillColor;
  final Color? fillBorderColor;
  final Color? hintColor;
  final Color? textColor;

  CustomTextField({
    super.key,
    required this.controller,
    required this.inputType,
    this.obscureText = false,
    this.confirmPasswordController,
    required this.labelText,
    required this.hintText,
    required this.textFieldVaidType,
    this.containtPaddingRight = 20,
    this.maxLength,
    this.maxLines = 1,
    this.maxerrorLines = 2,
    this.borderRadius,
    this.iconDataHeight,
    this.iconDataWidth,
    this.isDisable = false,
    this.firstPasswordToConfirm,
    this.prefixIcon,
    this.suffixIcon,
    this.onTapSuffix,
    this.fillColor,
    this.fillBorderColor,
    this.hintColor,
    this.hintFontSize,
    this.textColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        hintColor: AppColors.secondaryColor.withOpacity(.9),
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: AppColors.mainColor,
        // cursorHeight: 12,
        controller: widget.controller,
        autofocus: false,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,

        keyboardType: widget.inputType,
        obscureText: widget.obscureText,
        obscuringCharacter: '*',
        readOnly: widget.isDisable,
        validator: (v) => validation(
            type: widget.textFieldVaidType!,
            value: v!,
            firstPasswordForConfirm: ""),
        decoration: InputDecoration(
          errorMaxLines: widget.maxerrorLines,
          counter: const Offstage(),
          errorStyle: TextStyle(
              height: 1,
              fontFamily: AppFonts.regular,
              fontSize: 12.sp,
              color: AppColors.red),
          fillColor: widget.isDisable
              ? widget.fillColor ?? AppColors.cardColor
              : widget.fillColor ?? AppColors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              widget.borderRadius != null
                  ? widget.borderRadius!
                  : widget.maxLines == null
                      ? 12.sp
                      : 15.sp,
            ),
            borderSide: BorderSide(
                color: widget.fillColor == null
                    ? widget.isDisable
                        ? Colors.transparent
                        : widget.fillBorderColor ?? AppColors.grey
                    : widget.fillBorderColor!),
            gapPadding: 10,
          ),
          contentPadding:
              EdgeInsets.only(left: 12.w, right: 12.w, top: 10.h, bottom: 10.h),
          alignLabelWithHint: true,
          prefixIconConstraints: const BoxConstraints(
            maxWidth: 40,
            minWidth: 40,
            maxHeight: 24,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: widget.hintFontSize ?? 12.sp,
              color: widget.hintColor ?? AppColors.textColorHint,
              fontFamily: AppFonts.regular,
              fontWeight: AppFonts.w400),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius != null
                ? widget.borderRadius!
                : widget.maxLines == null
                    ? 12.sp
                    : 15.sp),
            borderSide:
                BorderSide(color: widget.fillBorderColor ?? AppColors.grey),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius != null
                ? widget.borderRadius!
                : widget.maxLines == null
                    ? 12.sp
                    : 15.sp),
            borderSide: const BorderSide(color: AppColors.grey),
            gapPadding: 10,
          ),
        ),
        style: TextStyle(
          fontSize: 16.sp,
          height: 1.4,
          color: widget.textColor ?? AppColors.black,
          fontFamily: AppFonts.regular,
        ),
      ),
    );
  }
}
