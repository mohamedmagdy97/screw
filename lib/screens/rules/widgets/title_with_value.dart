import 'package:flutter/material.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/utility/app_theme.dart';

class TitleWithValue extends StatelessWidget {
  final String title;
  final String value;
  final bool? highlight;
  final bool? isSmaller;

  const TitleWithValue({
    super.key,
    required this.title,
    this.highlight = false,
    this.isSmaller = false,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: title,
          fontSize: 16,
          textAlign: TextAlign.center,
          color: AppColors.mainColor,
        ),
        const SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.all(8),
            color: highlight! ? AppColors.mainColor.withOpacity(0.2) : null,
            child: CustomText(
                text: value,
                fontSize: isSmaller! ? 12 : 16,
                textAlign: isSmaller! ? TextAlign.end : TextAlign.center)),
        const SizedBox(height: 16),
      ],
    );
  }
}
