// import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screw_calc/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Admob.initialize();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}
