import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screw_calc/components/custom_button.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/components/text_filed_custom.dart';
import 'package:screw_calc/cubits/generic_cubit/generic_cubit.dart';
import 'package:screw_calc/models/item.dart';
import 'package:screw_calc/screens/home/home_data.dart';
import 'package:screw_calc/utility/app_theme.dart';
import 'package:screw_calc/utility/validation_form.dart';

class FriendsMode extends StatelessWidget {
  const FriendsMode({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        CustomText(
          text: "أختر عدد الفرق",
          fontSize: 16.sp,
          textAlign: TextAlign.end,
        ),
        const SizedBox(height: 16),
        BlocBuilder<GenericCubit<List<Item>>, GenericState<List<Item>>>(
          bloc: homeData.listTeamsCubit,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // spacing: 16.w,
                    // runSpacing: 16.h,
                    children: List.generate(
                      state.data!.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12.sp),
                          onTap: () => homeData.onSelectTeam(index),
                          child: Container(
                            width: (1.sw - 120.w) / 5,
                            height: 50,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.sp),
                              color: state.data![index].isActive!
                                  ? AppColors.mainColor
                                  : null,
                              border: Border.all(
                                color: !state.data![index].isActive!
                                    ? AppColors.mainColor
                                    : Colors.transparent,
                              ),
                            ),
                            child: CustomText(
                                text: state.data![index].value.toString(),
                                fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomText(
                  text: "الفريق الاول",
                  fontSize: 16.sp,
                  textAlign: TextAlign.end,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: homeData.playerOne,
                  hintText: '',
                  labelText: 'ادخل اسم اللاعب الاول',
                  containtPaddingRight: 0,
                  inputType: TextInputType.text,
                  textFieldVaidType: TextFieldValidatorType.displayText,
                ),
                CustomTextField(
                  controller: homeData.playerTwo,
                  hintText: '',
                  labelText: 'ادخل اسم اللاعب الثاني',
                  containtPaddingRight: 0,
                  inputType: TextInputType.text,
                  textFieldVaidType: TextFieldValidatorType.displayText,
                ),
                CustomText(
                  text: "الفريق الثاني",
                  fontSize: 16.sp,
                  textAlign: TextAlign.end,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: homeData.playerThree,
                  hintText: '',
                  labelText: 'ادخل اسم اللاعب الاول',
                  containtPaddingRight: 0,
                  inputType: TextInputType.text,
                  textFieldVaidType: TextFieldValidatorType.displayText,
                ),
                CustomTextField(
                  controller: homeData.playerFour,
                  hintText: '',
                  labelText: 'ادخل اسم اللاعب الثاني',
                  containtPaddingRight: 0,
                  inputType: TextInputType.text,
                  textFieldVaidType: TextFieldValidatorType.displayText,
                ),
                if (state.data!.firstWhere((e) => e.isActive == true).key! >=
                    3) ...[
                  CustomText(
                    text: "الفريق الثالث",
                    fontSize: 16.sp,
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: homeData.playerFive,
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب الاول',
                    containtPaddingRight: 0,
                    inputType: TextInputType.text,
                    textFieldVaidType: TextFieldValidatorType.displayText,
                  ),
                  CustomTextField(
                    controller: homeData.playerSix,
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب الثاني',
                    containtPaddingRight: 0,
                    inputType: TextInputType.text,
                    textFieldVaidType: TextFieldValidatorType.displayText,
                  ),
                ],
                if (state.data!.firstWhere((e) => e.isActive == true).key! >=
                    4) ...[
                  CustomText(
                    text: "الفريق الرابع",
                    fontSize: 16.sp,
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: homeData.playerOne2,
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب الاول',
                    containtPaddingRight: 0,
                    inputType: TextInputType.text,
                    textFieldVaidType: TextFieldValidatorType.displayText,
                  ),
                  CustomTextField(
                    controller: homeData.playerTwo2,
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب الثاني',
                    containtPaddingRight: 0,
                    inputType: TextInputType.text,
                    textFieldVaidType: TextFieldValidatorType.displayText,
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 16),
                  child: CustomButton(
                    text: "التالي",
                    onPressed: () => homeData.goToNextTeams(context),
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
