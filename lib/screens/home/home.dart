// import 'package:admob_flutter/admob_flutter.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screw_calc/components/custom_button.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/components/text_filed_custom.dart';
import 'package:screw_calc/cubits/generic_cubit/generic_cubit.dart';
import 'package:screw_calc/models/item.dart';
import 'package:screw_calc/screens/home/home_data.dart';
import 'package:screw_calc/screens/rules_screen.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeData.loadAd();
  }

  // final AdSize adSize = const AdSize(width: 300, height: 50);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => homeData.onWillPop(context),
      child: Scaffold(
          key: homeData.scaffoldKey,
          appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.grayy,
              title: CustomText(text: "سكرو", fontSize: 22.sp),
              actions: [
                InkWell(
                  onTap: () =>
                      homeData.scaffoldKey.currentState!.openEndDrawer(),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.menu, color: Colors.white),
                  ),
                ),
              ]),
          endDrawer: Padding(
            padding: EdgeInsets.only(top: 60.h, bottom: 54.h),
            child: SafeArea(
              child: Drawer(
                backgroundColor: AppColors.opacity_1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Image.asset("assets/icons/icon.png",
                            height: 0.15.sh),

                        // Icon(Icons.gavel_sharp,
                        //     size: 50, color: Colors.white),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child:
                            CustomText(text: "آهلا بيك يا صديقي", fontSize: 16),
                      ),
                      const Divider(endIndent: 10, indent: 10),
                      ListTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const RulesScreen()),
                        ),
                        title: const CustomText(
                          text: "قوانين اللعبه",
                          fontSize: 16,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      const ListTile(
                        title: CustomText(
                          text: "حول التطبيق",
                          fontSize: 16,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      // ListTile(
                      //   title: CustomText(
                      //     text: "لمعرفه اماكن شراء اللعبه",
                      //     fontSize: 16,
                      //     textAlign: TextAlign.end,
                      //   ),
                      // ),
                      const Spacer(),
                      const CustomText(
                        text: "version 1.0.0",
                        fontSize: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: homeData.bannerAd != null
              ? Container(
                  color: AppColors.grayy,
                  width: homeData.bannerAd!.size.width.toDouble(),
                  height: homeData.bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: homeData.bannerAd!),
                )
              : null,
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
            ),
          )),
    );
  }
}
