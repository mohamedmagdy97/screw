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

class ClassicMode extends StatelessWidget {
  const ClassicMode({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        CustomText(
            text: "أختر عدد الاعبيين",
            fontSize: 16.sp,
            textAlign: TextAlign.end),
        const SizedBox(height: 16),
        BlocBuilder<GenericCubit<List<Item>>, GenericState<List<Item>>>(
          bloc: homeData.listCubit,
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
                          onTap: () => homeData.onSelect(index),
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
                const SizedBox(height: 36),
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
                if (state.data!.firstWhere((e) => e.isActive == true).key! >= 3)
                  CustomTextField(
                    controller: homeData.playerThree,
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب الثالث',
                    containtPaddingRight: 0,
                    inputType: TextInputType.text,
                    textFieldVaidType: TextFieldValidatorType.displayText,
                  ),
                if (state.data!.firstWhere((e) => e.isActive == true).key! >= 4)
                  CustomTextField(
                    controller: homeData.playerFour,
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب الرابع',
                    containtPaddingRight: 0,
                    inputType: TextInputType.text,
                    textFieldVaidType: TextFieldValidatorType.displayText,
                  ),
                if (state.data!.firstWhere((e) => e.isActive == true).key! >= 5)
                  CustomTextField(
                    controller: homeData.playerFive,
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب الخامس',
                    containtPaddingRight: 0,
                    inputType: TextInputType.text,
                    textFieldVaidType: TextFieldValidatorType.displayText,
                  ),
                if (state.data!.firstWhere((e) => e.isActive == true).key! >= 6)
                  CustomTextField(
                    controller: homeData.playerSix,
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب السادس',
                    containtPaddingRight: 0,
                    inputType: TextInputType.text,
                    textFieldVaidType: TextFieldValidatorType.displayText,
                  ),
                if (state.data!.firstWhere((e) => e.isActive == true).key! >= 7)
                  CustomTextField(
                    controller: homeData.playerOne2,
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب السابع',
                    containtPaddingRight: 0,
                    inputType: TextInputType.text,
                    textFieldVaidType: TextFieldValidatorType.displayText,
                  ),
                if (state.data!.firstWhere((e) => e.isActive == true).key! >= 8)
                  CustomTextField(
                    controller: homeData.playerTwo2,
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب الثامن',
                    containtPaddingRight: 0,
                    inputType: TextInputType.text,
                    textFieldVaidType: TextFieldValidatorType.displayText,
                  ),
                if (state.data!.firstWhere((e) => e.isActive == true).key! >= 9)
                  CustomTextField(
                    controller: homeData.playerThree2,
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب التاسع',
                    containtPaddingRight: 0,
                    inputType: TextInputType.text,
                    textFieldVaidType: TextFieldValidatorType.displayText,
                  ),
                if (state.data!.firstWhere((e) => e.isActive == true).key! >=
                    10)
                  CustomTextField(
                    controller: homeData.playerFour2,
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب العاشر',
                    containtPaddingRight: 0,
                    inputType: TextInputType.text,
                    textFieldVaidType: TextFieldValidatorType.displayText,
                  ),
                if (state.data!.firstWhere((e) => e.isActive == true).key! >=
                    11)
                  CustomTextField(
                    controller: homeData.playerFive2,
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب الحادي عشر',
                    containtPaddingRight: 0,
                    inputType: TextInputType.text,
                    textFieldVaidType: TextFieldValidatorType.displayText,
                  ),
                if (state.data!.firstWhere((e) => e.isActive == true).key! >=
                    12)
                  CustomTextField(
                    controller: homeData.playerSix2,
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب الثاني عشر',
                    containtPaddingRight: 0,
                    inputType: TextInputType.text,
                    textFieldVaidType: TextFieldValidatorType.displayText,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 16),
                  child: CustomButton(
                    text: "التالي",
                    onPressed: () => homeData.goToNext(context),
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
