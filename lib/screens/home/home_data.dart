import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screw_calc/cubits/generic_cubit/generic_cubit.dart';
import 'package:screw_calc/models/item.dart';
import 'package:screw_calc/models/player_model.dart';
import 'package:screw_calc/screens/dashboard/dashboard.dart';

HomeData homeData = HomeData();

class HomeData {
  GenericCubit<List<Item>> listCubit = GenericCubit<List<Item>>(data: []);
  GenericCubit<List<Item>> listTeamsCubit = GenericCubit<List<Item>>(data: []);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController playerOne = TextEditingController();
  final TextEditingController playerTwo = TextEditingController();
  final TextEditingController playerThree = TextEditingController();
  final TextEditingController playerFour = TextEditingController();
  final TextEditingController playerFive = TextEditingController();
  final TextEditingController playerSix = TextEditingController();

  final TextEditingController playerOne2 = TextEditingController();
  final TextEditingController playerTwo2 = TextEditingController();

  final List<TextEditingController> controllers =
      List.generate(12, (_) => TextEditingController());

  List<PlayerModel> players = [];
  DateTime? currentBackPressTime;
  BannerAd? bannerAd;
  GenericCubit<bool> isLoadedCubit = GenericCubit(data: false);

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-2846618561973841/6485504999'
      : 'ca-app-pub-3940256099942544/2934735716';

  void loadAd() {
    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) => isLoadedCubit.update(data: true),
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  void init() {
    classicInit();
    friendsInit();
  }

  void classicInit() {
    listCubit.update(
        data: List.generate(
            11,
            (index) =>
                Item(key: index + 2, value: "${index + 2}", isActive: false)));

    listCubit.state.data!.first.isActive = true;
    listCubit.update(data: listCubit.state.data!);

    loadAd();
  }

  void friendsInit() {
    listTeamsCubit.update(
        data: List.generate(
            3,
            (index) =>
                Item(key: index + 2, value: "${index + 2}", isActive: false)));

    listTeamsCubit.state.data!.first.isActive = true;
    listTeamsCubit.update(data: listTeamsCubit.state.data!);

    loadAd();
  }

  void onSelect(int index) {
    for (var e in listCubit.state.data!) {
      e.isActive = false;
    }
    listCubit.state.data![index].isActive = true;
    listCubit.update(data: listCubit.state.data!);
  }

  void onSelectTeam(int index) {
    for (var e in listTeamsCubit.state.data!) {
      e.isActive = false;
    }
    listTeamsCubit.state.data![index].isActive = true;
    listTeamsCubit.update(data: listTeamsCubit.state.data!);
  }

  Future<void> goToNext(BuildContext context, {bool teamsMode = false}) async {
    if (!formKey.currentState!.validate()) return;

    players = controllers
        .asMap()
        .entries
        .map((entry) => PlayerModel(id: entry.key + 1, name: entry.value.text))
        .where((player) => player.name!.isNotEmpty)
        .toList();

    int playersCount = int.parse((teamsMode ? listTeamsCubit : listCubit)
            .state
            .data!
            .firstWhere((element) => element.isActive!)
            .value ??
        "2");

    players.removeWhere((element) => element.id! > playersCount);

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Dashboard(players: players, teamsMode: teamsMode),
      ),
    );

    players.clear();
  }

  goToNextTeams(context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    players.add(PlayerModel(id: 1, name: playerOne.text));
    players.add(PlayerModel(id: 2, name: playerTwo.text));
    players.add(PlayerModel(id: 3, name: playerThree.text ?? ""));
    players.add(PlayerModel(id: 4, name: playerFour.text ?? ""));
    players.add(PlayerModel(id: 5, name: playerFive.text ?? ""));
    players.add(PlayerModel(id: 6, name: playerSix.text ?? ""));
    players.add(PlayerModel(id: 7, name: playerOne2.text ?? ""));
    players.add(PlayerModel(id: 8, name: playerTwo2.text ?? ""));

    players.removeWhere((e) => e.name!.isEmpty);

    int playersCount;
    switch (int.parse(listTeamsCubit.state.data!
            .where((element) => element.isActive!)
            .toList()[0]
            .value ??
        "2")) {
      case 2:
        playersCount = 4;
        break;
      case 3:
        playersCount = 6;
        break;
      case 4:
        playersCount = 8;
        break;
      default:
        playersCount = 4;
        return;
    }

    players.removeWhere((element) => element.id! > playersCount);

    /* bool res = */

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Dashboard(players: players, teamsMode: true),
      ),
    );
    players.clear();
  }

  void showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(content), duration: const Duration(milliseconds: 1500)),
    );
  }

  clearValues() {
    players.forEach((element) {
      element.gw1 = "";
      element.gw2 = "";
      element.gw3 = "";
      element.gw4 = "";
      element.gw5 = "";
      element.total = "0";
    });
  }
}
