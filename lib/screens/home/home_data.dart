import 'dart:developer';
import 'dart:io';

// import 'package:admob_flutter/admob_flutter.dart';
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

  List<PlayerModel> players = [];

  init() async {
    List.generate(
        5,
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

    players.removeWhere((e) => e.name!.isEmpty);

    bool res = await Navigator.push(context,
        MaterialPageRoute(builder: (_) => Dashboard(players: players)));
    players.clear();

    if (res) {
      players.clear();
      playerOne.clear();
      playerTwo.clear();
      playerThree.clear();
      playerFour.clear();
      playerFive.clear();
      playerSix.clear();
      listCubit.state.data!.clear();
      listCubit.update(data: listCubit.state.data!);

      init();
    }
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
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          log('?>>>>>DFFDDFDF==${ad.responseInfo!.loadedAdapterResponseInfo!.description} loaded.');

          isLoadedCubit.update(data: true);
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {
          log('?>>>>>DFFDDFDF onAdOpened ==${ad.responseInfo!.loadedAdapterResponseInfo!.description} onAdOpened.');
        },
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {
          log('?>>>>>DFFDDFDF onAdClosed ==${ad.responseInfo!.loadedAdapterResponseInfo!.description} onAdClosed.');
        },
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {
          log('?>>>>>DFFDDFDF onAdImpression ==${ad.responseInfo!.loadedAdapterResponseInfo!.description} onAdImpression.');
        },
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
