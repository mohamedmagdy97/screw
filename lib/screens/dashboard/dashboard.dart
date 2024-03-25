import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screw_calc/components/custom_button.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/cubits/generic_cubit/generic_cubit.dart';
import 'package:screw_calc/helpers/ad_manager.dart';
import 'package:screw_calc/models/player_model.dart';
import 'package:screw_calc/screens/dashboard/dashboard_data.dart';
import 'package:screw_calc/screens/home/home_data.dart';
import 'package:screw_calc/screens/home/widgets/marquee_widget.dart';
import 'package:screw_calc/utility/app_theme.dart';

class Dashboard extends StatefulWidget {
  final List<PlayerModel> players;
  final bool? fromHistory;

  const Dashboard({Key? key, required this.players, this.fromHistory = false})
      : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DashboardData dashboardData = DashboardData();

  @override
  void initState() {
    homeData.loadAd();
    dashboardData.init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeData.loadAd();
    // AdManager().loadRewardedInterstitialAd();
    AdManager().loadInterstitialAd();
    dashboardData.loadNativeAdvanced();
  }

  @override
  void dispose() {
    dashboardData.nativeAd!.dispose();
    AdManager().disposeAds();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // widget.players.sort((a, b) => a.total!.compareTo(b.total!));

    int resWinner = int.parse(widget.players
        .reduce((curr, next) =>
            int.parse(curr.total!) < int.parse(next.total!) ? (curr) : (next))
        .total
        .toString());

    int gw = 1;
    if (widget.players
            .where((element) => element.gw1!.isNotEmpty)
            .toList()
            .length !=
        widget.players.length) {
      gw = 1;
    } else if (widget.players
            .where((element) => element.gw2!.isNotEmpty)
            .toList()
            .length !=
        widget.players.length) {
      gw = 2;
    } else if (widget.players
            .where((element) => element.gw3!.isNotEmpty)
            .toList()
            .length !=
        widget.players.length) {
      gw = 3;
    } else if (widget.players
            .where((element) => element.gw4!.isNotEmpty)
            .toList()
            .length !=
        widget.players.length) {
      gw = 4;
    } else if (widget.players
            .where((element) => element.gw5!.isNotEmpty)
            .toList()
            .length !=
        widget.players.length) {
      gw = 5;
    } else {
      gw = 10;
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(true);
      },
      // homeData.onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.grayy,
          leading: !widget.fromHistory!
              ? IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => Dialog(
                              backgroundColor: AppColors.bg,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 32),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text: "تحذير",
                                      fontSize: 18.sp,
                                      color: AppColors.mainColor,
                                    ),
                                    const SizedBox(height: 40),
                                    CustomText(
                                      text: "هل تريد اعادة بدأ الجولة",
                                      fontSize: 18.sp,
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const CustomText(
                                              text: "لا", fontSize: 18),
                                        ),
                                        CustomButton(
                                          width: 0.25.sw,
                                          height: 40,
                                          text: "نعم",
                                          isButtonBorder: true,
                                          onPressed: () {
                                            homeData.clearValues();
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                  },
                  icon: const Icon(Icons.refresh, color: AppColors.white),
                )
              : const SizedBox(),
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(context, true),
              icon: Transform.flip(
                flipX: true,
                child: const Icon(Icons.arrow_back_ios, color: AppColors.white),
              ),
            ),
          ],
          title: CustomText(text: "النتائج", fontSize: 22.sp),
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
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
                bloc: dashboardData.hideMarquee,
                builder: (context, state) {
                  if (state.data == false) {
                    return Container(
                      width: 1.sw,
                      padding: const EdgeInsets.all(8),
                      color: AppColors.black,
                      child: Row(
                        children: [
                          const Expanded(
                            child: MarqueeWidget(
                              direction: Axis.horizontal,
                              child: CustomText(
                                text:
                                    "              صلي على النبي, سبحان الله والحمد لله ولا اله الا الله ولا حول ولا قوة الا بالله, استغفر الله العظيم وأتوب اليه, لا اله الا انت سباحانك اني كنت من الظالمين        ",
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () =>
                                  dashboardData.hideMarquee.update(data: true),
                              icon: const Icon(
                                Icons.close,
                                color: AppColors.white,
                              ))
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 8),
              CustomText(
                text: gw == 10 ? "انتهت الجولات" : "الجولة رقم $gw",
                color: AppColors.mainColorLight,
                fontSize: 18,
              ),
              Expanded(
                child: SingleChildScrollView(
                  // shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                  child: Column(
                    children: [
                      ...List.generate(
                        widget.players.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            decoration: BoxDecoration(
                                color: resWinner.toString() ==
                                        widget.players[index].total
                                    ? AppColors.mainColor
                                    : null,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.grayy)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: widget.players[index].name
                                            .toString(),
                                        fontSize: 20.sp),
                                    const SizedBox(
                                        width: 20,
                                        child: Divider(color: AppColors.white)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Offstage(
                                            offstage:
                                                widget.players[index].gw1 ==
                                                        null ||
                                                    widget.players[index].gw1!
                                                        .isEmpty,
                                            child: CustomText(
                                                text:
                                                    " ${widget.players[index].gw1}",
                                                fontSize: 20.sp)),
                                        Offstage(
                                            offstage:
                                                widget.players[index].gw2 ==
                                                        null ||
                                                    widget.players[index].gw2!
                                                        .isEmpty,
                                            child: CustomText(
                                                text:
                                                    " + ${widget.players[index].gw2}",
                                                fontSize: 20.sp)),
                                        Offstage(
                                            offstage:
                                                widget.players[index].gw3 ==
                                                        null ||
                                                    widget.players[index].gw3!
                                                        .isEmpty,
                                            child: CustomText(
                                                text:
                                                    " + ${widget.players[index].gw3}",
                                                fontSize: 20.sp)),
                                        Offstage(
                                            offstage:
                                                widget.players[index].gw4 ==
                                                        null ||
                                                    widget.players[index].gw4!
                                                        .isEmpty,
                                            child: CustomText(
                                                text:
                                                    " + ${widget.players[index].gw4}",
                                                fontSize: 20.sp)),
                                        Offstage(
                                            offstage:
                                                widget.players[index].gw5 ==
                                                        null ||
                                                    widget.players[index].gw5!
                                                        .isEmpty,
                                            child: CustomText(
                                                text:
                                                    " + ${widget.players[index].gw5}",
                                                fontSize: 20.sp)),
                                        Offstage(
                                          offstage: widget.players[index].gw5 !=
                                                  null &&
                                              widget.players[index].gw5!
                                                  .isNotEmpty,
                                          child: IconButton(
                                            onPressed: () {
                                              // dashboardData.checkAllGwPlayed(gw,widget.players,index);
                                              dashboardData.addValue(context,
                                                  player:
                                                      widget.players[index]);
                                            },
                                            icon: const Icon(
                                                Icons.add_circle_sharp,
                                                color: AppColors.white,
                                                size: 30),
                                          ),
                                        ),
                                        const Spacer(),
                                        CustomText(text: "=", fontSize: 20.sp),
                                        CustomText(
                                            text:
                                                " ${widget.players[index].total}  ",
                                            fontSize: 20.sp),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (!widget.fromHistory!) ...[
                        const SizedBox(height: 8),
                        CustomText(
                          text:
                              " بعد انتهاء جميع الجولات يمكنك حفظها لتراها في السجلات الخاصة بك",
                          fontSize: 14.sp,
                        ),
                        const SizedBox(height: 8),
                        CustomButton(
                          text: "حفظ",
                          color: AppColors.textColorTitle,
                          onPressed: () =>
                              dashboardData.saveGame(widget.players, context),
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
                          bloc: dashboardData.isLoadedCubit,
                          builder: (context, state) {
                            if (state.data ?? false) {
                              return ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 320, // minimum recommended width
                                  minHeight: 220, // minimum recommended height
                                  maxWidth: 400,
                                  maxHeight: 300,
                                ),
                                child: AdWidget(ad: dashboardData.nativeAd!),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        )
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
