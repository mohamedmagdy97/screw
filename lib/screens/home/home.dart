import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/main.dart';
import 'package:screw_calc/screens/home/home_data.dart';
import 'package:screw_calc/screens/home/widgets/classic_mode.dart';
import 'package:screw_calc/screens/home/widgets/drawer_widget.dart';
import 'package:screw_calc/screens/home/widgets/friends_mode.dart';
import 'package:screw_calc/utility/app_theme.dart';

class MyHomePage extends StatefulWidget {
  final int gameMode;

  const MyHomePage({super.key, required this.gameMode});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(
    //   LifecycleEventHandler(
    //     resumeCallBack: () async => setState(
    //           () {
    //         // print('looooooooooool ===');
    //       },
    //     ),
    //   ),
    // );
    homeData.init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeData.loadAd();
    loadAppOpen();
  }

  // final AdSize adSize = const AdSize(width: 300, height: 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeData.scaffoldKey,
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.grayy,
          title: CustomText(text: "سكرو", fontSize: 22.sp),
          actions: [
            InkWell(
              onTap: () => homeData.scaffoldKey.currentState!.openEndDrawer(),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.menu, color: Colors.white),
              ),
            ),
          ]),
      endDrawer: const DrawerWidget(),
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
          child: widget.gameMode == 0
              ? const ClassicMode()
              : const FriendsMode()),
    );
  }
}
