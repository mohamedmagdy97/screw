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
import 'package:screw_calc/models/team_model_new.dart';
import 'package:screw_calc/screens/dashboard/widgets/add_value_dialog.dart';
import 'package:screw_calc/screens/dashboard/widgets/dashboard_appbar.dart';
import 'package:screw_calc/screens/dashboard/widgets/marquee_bar.dart';
import 'package:screw_calc/screens/home/home_data.dart';
import 'package:screw_calc/utility/app_theme.dart';
import 'package:screw_calc/utility/Enums.dart' as enums;

class Dashboard extends StatefulWidget {
  final List<PlayerModel> players;
  final bool? teamsMode;
  final bool? fromHistory;

  const Dashboard({
    super.key,
    required this.players,
    this.fromHistory = false,
    this.teamsMode = false,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardData dashboardData = DashboardData();
  late List<Team> teams;

  @override
  void initState() {
    dashboardData.init();

    // Assuming we have 4 players for 2 teams
    if (widget.teamsMode == true && widget.players.length >= 4) {
      teams = [
        Team(
            name: "الفريق الأول",
            playerOne: widget.players[0],
            playerTwo: widget.players[1]),
        Team(
            name: "الفريق الثاني",
            playerOne: widget.players[2],
            playerTwo: widget.players[3]),
        if (widget.players.length > 4)
          Team(
              name: "الفريق الثالث",
              playerOne: widget.players[4],
              playerTwo: widget.players[5]),
        if (widget.players.length > 6)
          Team(
              name: "الفريق الرابع",
              playerOne: widget.players[6],
              playerTwo: widget.players[7]),
      ];
    } else {
      teams = [];
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AdManager().loadInterstitialAd();
    dashboardData.loadNativeAdvanced();
  }

  @override
  void dispose() {
    dashboardData.nativeAd?.dispose();
    AdManager().disposeAds();
    super.dispose();
  }

  int getCurrentRound() {
    for (int i = 1; i <= 5; i++) {
      if (widget.players.any((player) => player.getRoundScore(i).isEmpty)) {
        return i;
      }
    }
    return 10;
  }

  @override
  Widget build(BuildContext context) {
    int gw = getCurrentRound();
    int resWinner = widget.players
        .map((p) => int.parse(p.total!))
        .reduce((a, b) => a < b ? a : b);

    Team? winningTeam;
    if (teams.isNotEmpty) {
      winningTeam = teams.reduce(
          (curr, next) => curr.totalScore < next.totalScore ? curr : next);
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        appBar: DashBoardAppBar(
          fromHistory: widget.fromHistory ?? false,
          onPressed: () {
            homeData.clearValues();
            setState(() {});
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.bg,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              MarqueeBar(dashboardData: dashboardData),
              const SizedBox(height: 8),
              CustomText(
                text: gw == 10 ? "انتهت الجولات" : "الجولة رقم $gw",
                color: AppColors.mainColorLight,
                fontSize: 18,
              ),
              enums.ModeClass.mode == enums.GameMode.classic
                  ? Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 1),
                        child: Column(
                          children: widget.players
                              .map((player) =>
                                  buildPlayerCard(player, resWinner))
                              .toList()
                            ..addAll(widget.fromHistory!
                                ? []
                                : buildGameSaveSection()),
                        ),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 1),
                        child: Column(children: [
                          // Display Teams
                          if (teams.isNotEmpty)
                            ...teams.map((team) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                  color: team == winningTeam
                                      ? AppColors.mainColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.grayy),
                                ),
                                child: Column(
                                  children: [
                                    CustomText(
                                        text: team.name,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                    Row(
                                      children: [
                                        CustomText(
                                            text: "${team.playerOne.name} :: ",
                                            fontSize: 16.sp),
                                        Expanded(
                                            child: buildPlayerScoresRow(
                                                team.playerOne)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CustomText(
                                            text: "${team.playerTwo.name} :: ",
                                            fontSize: 16.sp),
                                        Expanded(
                                            child: buildPlayerScoresRow(
                                                team.playerTwo)),
                                      ],
                                    ),
                                    const Divider(),
                                    CustomText(
                                        text: "المجموع: ${team.totalScore}",
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ],
                                ),
                              );
                            }).toList(),

                          Column(children: [
                            const SizedBox(height: 16),
                            CustomButton(
                              text: "اعادة بدأ الجولة",
                              color: AppColors.textColorTitle,
                              onPressed: () =>
                                  dashboardData.reloadGame(context, () {
                                homeData.clearValues();
                                setState(() {});
                                Navigator.pop(context);
                              }),
                            ),
                            /* CustomText(
                                text:
                                    "بعد انتهاء جميع الجولات يمكنك حفظها لتراها في السجلات الخاصة بك",
                                fontSize: 14.sp),
                            const SizedBox(height: 8),
                            CustomButton(
                                text: "حفظ",
                                color: AppColors.textColorTitle,
                                onPressed: () => dashboardData.saveGame(
                                    widget.players, context)),*/
                            const SizedBox(height: 20),
                            BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
                              bloc: dashboardData.isLoadedCubit,
                              builder: (context, state) => state.data ?? false
                                  ? ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          minWidth: 320,
                                          minHeight: 220,
                                          maxWidth: 400,
                                          maxHeight: 300),
                                      child:
                                          AdWidget(ad: dashboardData.nativeAd!),
                                    )
                                  : const SizedBox(),
                            ),
                          ])
                        ]
                            /* widget.players
                              .map((player) =>
                                  buildPlayerCard(player, resWinner))
                              .toList()
                            ..addAll(widget.fromHistory!
                                ? []
                                : buildGameSaveSection()),*/
                            ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPlayerCard(PlayerModel player, int resWinner) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        decoration: BoxDecoration(
          color:
              resWinner.toString() == player.total ? AppColors.mainColor : null,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grayy),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: player.name.toString(), fontSize: 20.sp),
            const SizedBox(width: 20, child: Divider(color: AppColors.white)),
            const SizedBox(height: 8),
            buildPlayerScoresRow(player),
          ],
        ),
      ),
    );
  }

  Widget buildPlayerScoresRow(PlayerModel player) {
    return Row(
      children: List.generate(5, (i) {
        String? roundScore = player.getRoundScore(i + 1);
        return roundScore != null && roundScore.isNotEmpty
            ? CustomText(
                text: i == 0 ? " $roundScore" : " + $roundScore",
                fontSize: 20.sp)
            : const SizedBox();
      })
        ..addAll([
          if (player.gw5!.isEmpty)
            IconButton(
              onPressed: player.gw5?.isNotEmpty ?? false
                  ? null
                  : () async {
                      await addValue(context, player: player);
                      setState(() {});
                    },
              icon: const Icon(Icons.add_circle_sharp,
                  color: AppColors.white, size: 30),
            ),
          const Spacer(),
          CustomText(text: "=", fontSize: 20.sp),
          CustomText(text: " ${player.total} ", fontSize: 20.sp),
        ]),
    );
  }

  List<Widget> buildGameSaveSection() {
    return [
      const SizedBox(height: 8),
      CustomText(
          text:
              "بعد انتهاء جميع الجولات يمكنك حفظها لتراها في السجلات الخاصة بك",
          fontSize: 14.sp),
      const SizedBox(height: 8),
      CustomButton(
          text: "حفظ",
          color: AppColors.textColorTitle,
          onPressed: () => dashboardData.saveGame(widget.players, context)),
      const SizedBox(height: 20),
      BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
        bloc: dashboardData.isLoadedCubit,
        builder: (context, state) => state.data ?? false
            ? ConstrainedBox(
                constraints: const BoxConstraints(
                    minWidth: 320,
                    minHeight: 220,
                    maxWidth: 400,
                    maxHeight: 300),
                child: AdWidget(ad: dashboardData.nativeAd!),
              )
            : const SizedBox(),
      ),
    ];
  }

  addValue(BuildContext context, {required PlayerModel player}) {
    showDialog(
      context: context,
      builder: (_) => AddValueDialog(
          dashboardData: dashboardData,
          player: player,
          fun: () => setState(() {})),
    );
  }
}
