import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/screens/home/home_data.dart';
import 'package:screw_calc/utility/app_theme.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({Key? key}) : super(key: key);

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.grayy,
        title: CustomText(text: "قوانين اللعبه", fontSize: 22.sp),
      ),
      backgroundColor: AppColors.bg,
      bottomNavigationBar: homeData.bannerAd != null
          ? Container(
              color: AppColors.grayy,
              width: homeData.bannerAd!.size.width.toDouble(),
              height: homeData.bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: homeData.bannerAd!),
            )
          : null,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Image.asset("assets/icons/icon.png", height: 0.15.sh),
          ),
          const TitleWithValue(
            title: "هدف اللعبة",
            value:
                "مع كل راوند تتخلص من الكروت التقيلة لحد ما يبقى معاك أقل سكور يخليك تقول سكرول",
          ),
          const TitleWithValue(
            title: "هدف اللعبة",
            value:
                "مع كل راوند تتخلص من الكروت التقيلة لحد ما يبقى معاك أقل سكور يخليك تقول سكرول",
          ),
        ],
      ),
    );
  }
}

class TitleWithValue extends StatelessWidget {
  final String title;
  final String value;

  const TitleWithValue({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: title,
          fontSize: 16,
          textAlign: TextAlign.center,
          color: AppColors.mainColor,
        ),
        const SizedBox(height: 10),
        CustomText(text: value, fontSize: 16, textAlign: TextAlign.center),
        const SizedBox(height: 16),
      ],
    );
  }
}
