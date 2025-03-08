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
                for (int i = 0;
                    i < state.data!.firstWhere((e) => e.isActive == true).key!;
                    i++)
                  CustomTextField(
                    controller: homeData.controllers[i],
                    hintText: '',
                    labelText: 'ادخل اسم اللاعب ${i + 1}',
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
        ),
      ],
    );
  }
}
