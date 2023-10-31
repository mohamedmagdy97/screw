import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screw_calc/components/custom_button.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/components/text_filed_custom.dart';
import 'package:screw_calc/models/player_model.dart';
import 'package:screw_calc/utility/app_theme.dart';
import 'package:screw_calc/utility/validation_form.dart';

class DashboardData {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  addValue(context, {required PlayerModel player}) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Directionality(
                textDirection: TextDirection.rtl,
                child: CustomText(
                  text: 'نتيجة الاعب ${player.name} في الجولة ',
                  fontSize: 14.sp,
                  textAlign: TextAlign.center,
                  color: AppColors.black,
                ),
              ),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      controller: controller,
                      hintText: '',
                      labelText: '',
                      containtPaddingRight: 0,
                      inputType: TextInputType.number,
                      fillColor: Colors.white,
                      textColor: Colors.black,
                      fillBorderColor: AppColors.grayy,
                      textFieldVaidType: TextFieldValidatorType.Number,
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'التالي',
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        Navigator.pop(context);
                        if (player.gw1!.isEmpty) {
                          player.gw1 = controller.text;

                          player.total =
                              (int.parse(player.gw1.toString())).toString();
                        } else if (player.gw2!.isEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw2 = controller.text;

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()))
                              .toString();
                        } else if (player.gw3!.isEmpty &&
                            player.gw2!.isNotEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw3 = controller.text;

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()) +
                                  int.parse(player.gw3.toString()))
                              .toString();
                        } else if (player.gw4!.isEmpty &&
                            player.gw3!.isNotEmpty &&
                            player.gw2!.isNotEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw4 = controller.text;

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()) +
                                  int.parse(player.gw3.toString()) +
                                  int.parse(player.gw4.toString()))
                              .toString();
                        } else if (player.gw5!.isEmpty &&
                            player.gw4!.isNotEmpty &&
                            player.gw3!.isNotEmpty &&
                            player.gw2!.isNotEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw5 = controller.text;

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()) +
                                  int.parse(player.gw3.toString()) +
                                  int.parse(player.gw4.toString()) +
                                  int.parse(player.gw5.toString()))
                              .toString();
                        }

                        controller.clear();
                      },
                    )
                  ],
                ),
              ),
            ));
  }
}
