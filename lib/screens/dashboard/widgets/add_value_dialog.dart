import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screw_calc/components/custom_button.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/components/text_filed_custom.dart';
import 'package:screw_calc/models/player_model.dart';
import 'package:screw_calc/screens/dashboard/dashboard_data.dart';
import 'package:screw_calc/utility/app_theme.dart';
import 'package:screw_calc/utility/validation_form.dart';

class AddValueDialog extends StatelessWidget {
  final DashboardData dashboardData;
  final PlayerModel player;
  final Function fun;

  const AddValueDialog(
      {super.key,
      required this.dashboardData,
      required this.player,
      required this.fun});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
        key: dashboardData.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: dashboardData.controller,
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
                if (!dashboardData.formKey.currentState!.validate()) {
                  return;
                }
                Navigator.pop(context);
                if (player.gw1!.isEmpty) {
                  player.gw1 = dashboardData.controller.text;

                  player.total =
                      (int.parse(player.gw1.toString())).toString();
                } else if (player.gw2!.isEmpty &&
                    player.gw1!.isNotEmpty) {
                  player.gw2 = dashboardData.controller.text;

                  player.total =
                      (int.parse(player.gw1.toString()) +
                              int.parse(player.gw2.toString()))
                          .toString();
                } else if (player.gw3!.isEmpty &&
                    player.gw2!.isNotEmpty &&
                    player.gw1!.isNotEmpty) {
                  player.gw3 = dashboardData.controller.text;

                  player.total =
                      (int.parse(player.gw1.toString()) +
                              int.parse(player.gw2.toString()) +
                              int.parse(player.gw3.toString()))
                          .toString();
                } else if (player.gw4!.isEmpty &&
                    player.gw3!.isNotEmpty &&
                    player.gw2!.isNotEmpty &&
                    player.gw1!.isNotEmpty) {
                  player.gw4 = dashboardData.controller.text;

                  player.total =
                      (int.parse(player.gw1.toString()) +
                              int.parse(player.gw2.toString()) +
                              int.parse(player.gw3.toString()) +
                              int.parse(player.gw4.toString()))
                          .toString();
                } else if (player.gw5!.isEmpty &&
                    player.gw4!.isNotEmpty &&
                    player.gw3!.isNotEmpty &&
                    player.gw2!.isNotEmpty &&
                    player.gw1!.isNotEmpty) {
                  player.gw5 = dashboardData.controller.text;

                  player.total =
                      (int.parse(player.gw1.toString()) +
                              int.parse(player.gw2.toString()) +
                              int.parse(player.gw3.toString()) +
                              int.parse(player.gw4.toString()) +
                              int.parse(player.gw5.toString()))
                          .toString();
                }

                dashboardData.controller.clear();

                fun();
              },
            ),
            const SizedBox(height: 16),
            // if (player.gw5!.isEmpty &&
            //     player.gw4!.isNotEmpty &&
            //     player.gw3!.isNotEmpty &&
            //     player.gw2!.isNotEmpty &&
            //     player.gw1!.isNotEmpty)
            /// 2 x آحسب النتيجه
            CustomButton(
              text: ' 2 x احسب النتيجة ',
              onPressed: () {
                if (!dashboardData.formKey.currentState!.validate()) {
                  return;
                }
                Navigator.pop(context);
                if (player.gw1!.isEmpty) {
                  player.gw1 = (int.parse(
                              dashboardData.controller.text.toString()) *
                          2)
                      .toString();

                  player.total =
                      (int.parse(player.gw1.toString())).toString();
                } else if (player.gw2!.isEmpty &&
                    player.gw1!.isNotEmpty) {
                  player.gw2 = (int.parse(
                              dashboardData.controller.text.toString()) *
                          2)
                      .toString();

                  player.total =
                      (int.parse(player.gw1.toString()) +
                              int.parse(player.gw2.toString()))
                          .toString();
                } else if (player.gw3!.isEmpty &&
                    player.gw2!.isNotEmpty &&
                    player.gw1!.isNotEmpty) {
                  player.gw3 = (int.parse(
                              dashboardData.controller.text.toString()) *
                          2)
                      .toString();

                  player.total =
                      (int.parse(player.gw1.toString()) +
                              int.parse(player.gw2.toString()) +
                              int.parse(player.gw3.toString()))
                          .toString();
                } else if (player.gw4!.isEmpty &&
                    player.gw3!.isNotEmpty &&
                    player.gw2!.isNotEmpty &&
                    player.gw1!.isNotEmpty) {
                  player.gw4 = (int.parse(
                              dashboardData.controller.text.toString()) *
                          2)
                      .toString();

                  player.total =
                      (int.parse(player.gw1.toString()) +
                              int.parse(player.gw2.toString()) +
                              int.parse(player.gw3.toString()) +
                              int.parse(player.gw4.toString()))
                          .toString();
                } else if (player.gw5!.isEmpty &&
                    player.gw4!.isNotEmpty &&
                    player.gw3!.isNotEmpty &&
                    player.gw2!.isNotEmpty &&
                    player.gw1!.isNotEmpty) {
                  player.gw5 = (int.parse(
                              dashboardData.controller.text.toString()) *
                          2)
                      .toString();

                  player.total =
                      (int.parse(player.gw1.toString()) +
                              int.parse(player.gw2.toString()) +
                              int.parse(player.gw3.toString()) +
                              int.parse(player.gw4.toString()) +
                              (int.parse(player.gw5.toString())))
                          .toString();
                }

                dashboardData.controller.clear();

                fun();
              },
            ),

            /// 4 x آحسب النتيجه
            if (player.gw5!.isEmpty &&
                player.gw4!.isNotEmpty &&
                player.gw3!.isNotEmpty &&
                player.gw2!.isNotEmpty &&
                player.gw1!.isNotEmpty) ...[
              const SizedBox(height: 16),
              CustomButton(
                text: ' 4 x احسب النتيجة ',
                onPressed: () {
                  if (!dashboardData.formKey.currentState!.validate()) {
                    return;
                  }
                  Navigator.pop(context);
                  if (player.gw5!.isEmpty &&
                      player.gw4!.isNotEmpty &&
                      player.gw3!.isNotEmpty &&
                      player.gw2!.isNotEmpty &&
                      player.gw1!.isNotEmpty) {
                    player.gw5 = (int.parse(dashboardData.controller.text
                                .toString()) *
                            4)
                        .toString();
                    player.total =
                        (int.parse(player.gw1.toString()) +
                                int.parse(player.gw2.toString()) +
                                int.parse(player.gw3.toString()) +
                                int.parse(player.gw4.toString()) +
                                (int.parse(player.gw5.toString())))
                            .toString();
                  }

                  dashboardData.controller.clear();

                  fun();
                },
              ),
            ],
            const SizedBox(height: 16),

            /// سكرو (0)
            CustomButton(
              text: ' سكرو (0) ',
              onPressed: () {
                dashboardData.controller.text = "0";
                // if (!formKey.currentState!.validate()) {
                //   return;
                // }
                Navigator.pop(context);
                if (player.gw1!.isEmpty) {
                  player.gw1 = "0";

                  player.total =
                      (int.parse(player.gw1.toString())).toString();
                } else if (player.gw2!.isEmpty &&
                    player.gw1!.isNotEmpty) {
                  player.gw2 = "0";

                  player.total =
                      (int.parse(player.gw1.toString()) +
                              int.parse(player.gw2.toString()))
                          .toString();
                } else if (player.gw3!.isEmpty &&
                    player.gw2!.isNotEmpty &&
                    player.gw1!.isNotEmpty) {
                  player.gw3 = "0";

                  player.total =
                      (int.parse(player.gw1.toString()) +
                              int.parse(player.gw2.toString()) +
                              int.parse(player.gw3.toString()))
                          .toString();
                } else if (player.gw4!.isEmpty &&
                    player.gw3!.isNotEmpty &&
                    player.gw2!.isNotEmpty &&
                    player.gw1!.isNotEmpty) {
                  player.gw4 = "0";

                  player.total =
                      (int.parse(player.gw1.toString()) +
                              int.parse(player.gw2.toString()) +
                              int.parse(player.gw3.toString()) +
                              int.parse(player.gw4.toString()))
                          .toString();
                } else if (player.gw5!.isEmpty &&
                    player.gw4!.isNotEmpty &&
                    player.gw3!.isNotEmpty &&
                    player.gw2!.isNotEmpty &&
                    player.gw1!.isNotEmpty) {
                  player.gw5 = "0";
                  player.total =
                      (int.parse(player.gw1.toString()) +
                              int.parse(player.gw2.toString()) +
                              int.parse(player.gw3.toString()) +
                              int.parse(player.gw4.toString()) +
                              (int.parse(player.gw5.toString())))
                          .toString();
                }

                dashboardData.controller.clear();

                fun();
              },
            ),
            const SizedBox(height: 16),
            CustomText(
              text: "انتبه لا يمكن التعديل على النتيجة",
              fontSize: 14.sp,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}
