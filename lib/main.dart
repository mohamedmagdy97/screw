import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screw_calc/my_app.dart';
import 'package:provider/provider.dart';
import 'package:screw_calc/screens/dashboard/dashboard_chatgpt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // loadAppOpen();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(
    /// dashboard chat gpt
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameProvider()),
      ],
      child:
      const MyApp(),
    ),
  );
}

AppOpenAd? appOpenAd;

loadAppOpen() {
  AppOpenAd.load(
    adUnitId: "ca-app-pub-2846618561973841/8352003781",
    request: const AdRequest(),
    adLoadCallback: AppOpenAdLoadCallback(
      onAdLoaded: (ads) {
        appOpenAd = ads;
        appOpenAd!.show();
      },
      onAdFailedToLoad: (adsFail) => log("Error message===========$adsFail"),
    ),

    // orientation: AppOpenAd.orientationPortrait,
  );
}
