import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/models/player_model.dart';
import 'package:screw_calc/screens/dashboard/dashboard_data.dart';
import 'package:screw_calc/screens/home/home_data.dart';
import 'package:screw_calc/utility/app_theme.dart';

class Dashboard extends StatefulWidget {
  final List<PlayerModel> players;

  const Dashboard({Key? key, required this.players}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DashboardData dashboardData = DashboardData();

  @override
  void initState() {
    homeData.loadAd();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeData.loadAd();
  }

  @override
  Widget build(BuildContext context) {
    // widget.players.sort((a, b) => a.total!.compareTo(b.total!));

    int resWinner = int.parse(widget.players
        .reduce((curr, next) =>
            int.parse(curr.total!) < int.parse(next.total!) ? (curr) : (next))
        .total
        .toString());
    return WillPopScope(
      onWillPop: () => homeData.onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.grayy,
          leading: IconButton(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.refresh, color: AppColors.white),
          ),
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
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            children: [
              ...List.generate(
                widget.players.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    decoration: BoxDecoration(
                        color:
                            resWinner.toString() == widget.players[index].total
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
                                text: widget.players[index].name.toString(),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Offstage(
                                    offstage:
                                        widget.players[index].gw1 == null ||
                                            widget.players[index].gw1!.isEmpty,
                                    child: CustomText(
                                        text: " ${widget.players[index].gw1}",
                                        fontSize: 20.sp)),
                                Offstage(
                                    offstage:
                                        widget.players[index].gw2 == null ||
                                            widget.players[index].gw2!.isEmpty,
                                    child: CustomText(
                                        text: " + ${widget.players[index].gw2}",
                                        fontSize: 20.sp)),
                                Offstage(
                                    offstage:
                                        widget.players[index].gw3 == null ||
                                            widget.players[index].gw3!.isEmpty,
                                    child: CustomText(
                                        text: " + ${widget.players[index].gw3}",
                                        fontSize: 20.sp)),
                                Offstage(
                                    offstage:
                                        widget.players[index].gw4 == null ||
                                            widget.players[index].gw4!.isEmpty,
                                    child: CustomText(
                                        text: " + ${widget.players[index].gw4}",
                                        fontSize: 20.sp)),
                                Offstage(
                                    offstage:
                                        widget.players[index].gw5 == null ||
                                            widget.players[index].gw5!.isEmpty,
                                    child: CustomText(
                                        text: " + ${widget.players[index].gw5}",
                                        fontSize: 20.sp)),
                                Offstage(
                                  offstage: widget.players[index].gw5 != null &&
                                      widget.players[index].gw5!.isNotEmpty,
                                  child: IconButton(
                                    onPressed: () => dashboardData.addValue(
                                        context,
                                        player: widget.players[index]),
                                    icon: const Icon(Icons.add_circle_sharp,
                                        color: AppColors.white, size: 30),
                                  ),
                                ),
                                const Spacer(),
                                CustomText(text: "=", fontSize: 20.sp),
                                CustomText(
                                    text: " ${widget.players[index].total}  ",
                                    fontSize: 20.sp),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
