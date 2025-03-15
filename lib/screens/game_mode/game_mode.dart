import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screw_calc/components/custom_button.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/components/text_filed_custom.dart';
import 'package:screw_calc/cubits/generic_cubit/generic_cubit.dart';
import 'package:screw_calc/helpers/app_life_sycle.dart';
import 'package:screw_calc/main.dart';
import 'package:screw_calc/models/item.dart';
import 'package:screw_calc/screens/game_mode/game_mode_data.dart';
import 'package:screw_calc/screens/home/home_data.dart';
import 'package:screw_calc/screens/home/widgets/drawer_widget.dart';
import 'package:screw_calc/utility/app_theme.dart';
import 'package:screw_calc/utility/validation_form.dart';

class GameMode extends StatefulWidget {
  const GameMode({super.key});

  @override
  State<GameMode> createState() => _GameModeState();
}

class _GameModeState extends State<GameMode> {
  GameModeData gameModeData = GameModeData();

  @override
  void initState() {
    gameModeData.init();
    super.initState();
  }

  // final AdSize adSize = const AdSize(width: 300, height: 50);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => gameModeData.onWillPop(context),
      child: Scaffold(
          key: gameModeData.scaffoldKey,
          appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.grayy,
              title: CustomText(text: "سكرو", fontSize: 22.sp),
    ),
          backgroundColor: AppColors.bg,
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              CustomText(
                  text: "Game mode",
                  fontSize: 16.sp,
                  textAlign: TextAlign.center),
              const SizedBox(height: 16),
              BlocBuilder<GenericCubit<List<Item>>, GenericState<List<Item>>>(
                bloc: gameModeData.listCubit,
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          // spacing: 16.w,
                          // runSpacing: 16.h,
                          children: List.generate(
                            state.data!.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12.sp),
                                onTap: () => gameModeData.onSelect(context,index),
                                child: Container(
                                  width:1.sw /* (1.sw - 120.w) / 5*/,
                                  height: (1.sh-0.5.sh) / 3,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(12.sp),
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
                                      text:
                                          state.data![index].value.toString(),
                                      fontSize: 18.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 16),
                        child: CustomButton(
                          text: "التالي",
                          onPressed: () => gameModeData.goToHome(context),
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          )),
    );
  }
}
