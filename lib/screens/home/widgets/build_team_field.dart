import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/components/text_filed_custom.dart';
import 'package:screw_calc/utility/validation_form.dart';

class BuildTeamFields extends StatelessWidget {
  final String teamName;
  final List<TextEditingController> controllers;

  const BuildTeamFields({
    super.key,
    required this.teamName,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomText(text: teamName, fontSize: 16.sp, textAlign: TextAlign.end),
        const SizedBox(height: 8),
        ...controllers.map(
          (controller) => CustomTextField(
            controller: controller,
            hintText: '',
            labelText: 'ادخل اسم اللاعب',
            containtPaddingRight: 0,
            inputType: TextInputType.text,
            textFieldVaidType: TextFieldValidatorType.displayText,
          ),
        ),
      ],
    );
  }
}
