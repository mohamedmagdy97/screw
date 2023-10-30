import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/components/dox_decoration.dart';
import 'package:screw_calc/components/text_filed_custom.dart';
import 'package:screw_calc/cubits/generic_cubit/generic_cubit.dart';
import 'package:screw_calc/models/item.dart';
import 'package:screw_calc/screens/home/home_data.dart';
import 'package:screw_calc/utility/app_theme.dart';
import 'package:screw_calc/utility/validation_form.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeData homeData = HomeData();

  @override
  void initState() {
    homeData.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.grayy,
          title: CustomText(
            text: "سكرو",
            fontSize: 22.sp,
          ),
        ),
        backgroundColor: AppColors.bg,
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            CustomText(text: "أختر عدد الاعبيين", fontSize: 16.sp),
            SizedBox(height: 16.h),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
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
                    SizedBox(height: 16),
                    CustomTextField(
                      controller: homeData.playerOne,
                      hintText: '',
                      labelText: 'ادخل اسم اللاعب الاول',
                      containtPaddingRight: 0,
                      inputType: TextInputType.text,
                      textFieldVaidType: TextFieldValidatorType.name,
                    ),
                  ],
                );
              },
            )
          ],
        ));
  }
}
