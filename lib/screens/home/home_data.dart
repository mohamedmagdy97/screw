import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screw_calc/cubits/generic_cubit/generic_cubit.dart';
import 'package:screw_calc/models/item.dart';
import 'package:screw_calc/models/player_model.dart';
import 'package:screw_calc/screens/dashboard/dashboard.dart';
import 'package:screw_calc/utility/utilities.dart';

HomeData homeData = HomeData();

class HomeData {
  GenericCubit<List<Item>> listCubit = GenericCubit<List<Item>>(data: []);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController playerOne = TextEditingController();
  final TextEditingController playerTwo = TextEditingController();
  final TextEditingController playerThree = TextEditingController();
  final TextEditingController playerFour = TextEditingController();
  final TextEditingController playerFive = TextEditingController();
  final TextEditingController playerSix = TextEditingController();

  final TextEditingController playerOne2 = TextEditingController();
  final TextEditingController playerTwo2 = TextEditingController();
  final TextEditingController playerThree2 = TextEditingController();
  final TextEditingController playerFour2 = TextEditingController();
  final TextEditingController playerFive2 = TextEditingController();
  final TextEditingController playerSix2 = TextEditingController();

  List<PlayerModel> players = [];

  init() async {
    List.generate(
        11,
        (index) => listCubit.state.data!.add(
            Item(key: (index + 2), value: "${index + 2}", isActive: false)));

    listCubit.state.data!.first.isActive = true;
    listCubit.update(data: listCubit.state.data!);

    loadAd();
  }

  onSelect(index) {
    listCubit.state.data!.map((e) => e.isActive = false).toList();
    listCubit.update(data: listCubit.state.data!);

    listCubit.state.data![index].isActive = true;
    listCubit.update(data: listCubit.state.data!);
  }

  goToNext(context) async {
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
    players.add(PlayerModel(id: 9, name: playerThree2.text ?? ""));
    players.add(PlayerModel(id: 10, name: playerFour2.text ?? ""));
    players.add(PlayerModel(id: 11, name: playerFive2.text ?? ""));
    players.add(PlayerModel(id: 12, name: playerSix2.text ?? ""));

    players.removeWhere((e) => e.name!.isEmpty);

    int playersCount = int.parse(listCubit.state.data!
        .where((element) => element.isActive!)
        .toList()[0]
        .value ??
        "2");
    players.removeWhere((element) => element.id! > playersCount);

    /* bool res = */
    await Navigator.push(context,
        MaterialPageRoute(builder: (_) => Dashboard(players: players)));
    players.clear();

    // if (res) {
    //   players.clear();
    //   playerOne.clear();
    //   playerTwo.clear();
    //   playerThree.clear();
    //   playerFour.clear();
    //   playerFive.clear();
    //   playerSix.clear();
    //   listCubit.state.data!.clear();
    //   listCubit.update(data: listCubit.state.data!);
    //
    //   init();
    // }
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

  DateTime? currentBackPressTime;

  Future<bool> onWillPop(context) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Utilities().customSnackBarTerms(context, txt: "للخروج اضغط مرتين ");
      return Future.value(false);
    }
    return Future.value(true);
  }

  BannerAd? bannerAd;
  GenericCubit<bool> isLoadedCubit = GenericCubit(data: false);

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-2846618561973841/6485504999'
      : 'ca-app-pub-3940256099942544/2934735716';
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void loadAd() {
    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isLoadedCubit.update(data: true);
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        onAdOpened: (Ad ad) {},
        onAdClosed: (Ad ad) {},
        onAdImpression: (Ad ad) {},
      ),
    )..load();
  }

  void showSnackBar(String content, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  String? getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2846618561973841/6485504999';
    }
    return null;
  }
}
