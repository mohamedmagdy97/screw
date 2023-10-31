import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    homeData.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => homeData.onWillPop(context),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.grayy,
            title: CustomText(text: "سكرو", fontSize: 22.sp),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButton(
              text: "التالي",
              onPressed: () => homeData.goToNext(context),
            ),
          ),
          backgroundColor: AppColors.bg,
          body: Form(
            key: homeData.formKey,
            child: ListView(
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
                        Wrap(
                          spacing: 16.w,
                          runSpacing: 16.h,
                          children: List.generate(
                            state.data!.length,
                            (index) => InkWell(
                              borderRadius: BorderRadius.circular(12.sp),
                              onTap: () => homeData.onSelect(index),
                              child: Container(
                                width: (1.sw - 120.w) / 5,
                                height: 50,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
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
                          ).reversed.toList(),
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
                        if (state.data!
                                .firstWhere((e) => e.isActive == true)
                                .key! >=
                            3)
                          CustomTextField(
                            controller: homeData.playerThree,
                            hintText: '',
                            labelText: 'ادخل اسم اللاعب الثالث',
                            containtPaddingRight: 0,
                            inputType: TextInputType.text,
                            textFieldVaidType:
                                TextFieldValidatorType.displayText,
                          ),
                        if (state.data!
                                .firstWhere((e) => e.isActive == true)
                                .key! >=
                            4)
                          CustomTextField(
                            controller: homeData.playerFour,
                            hintText: '',
                            labelText: 'ادخل اسم اللاعب الرابع',
                            containtPaddingRight: 0,
                            inputType: TextInputType.text,
                            textFieldVaidType:
                                TextFieldValidatorType.displayText,
                          ),
                        if (state.data!
                                .firstWhere((e) => e.isActive == true)
                                .key! >=
                            5)
                          CustomTextField(
                            controller: homeData.playerFive,
                            hintText: '',
                            labelText: 'ادخل اسم اللاعب الخامس',
                            containtPaddingRight: 0,
                            inputType: TextInputType.text,
                            textFieldVaidType:
                                TextFieldValidatorType.displayText,
                          ),
                        if (state.data!
                                .firstWhere((e) => e.isActive == true)
                                .key! >=
                            6)
                          CustomTextField(
                            controller: homeData.playerSix,
                            hintText: '',
                            labelText: 'ادخل اسم اللاعب السادس',
                            containtPaddingRight: 0,
                            inputType: TextInputType.text,
                            textFieldVaidType:
                                TextFieldValidatorType.displayText,
                          ),
                      ],
                    );
                  },
                )
              ],
            ),
          )),
    );
  }
}
