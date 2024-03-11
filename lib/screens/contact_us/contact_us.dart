import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/main.dart';
import 'package:screw_calc/screens/home/home_data.dart';
import 'package:screw_calc/utility/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUS extends StatefulWidget {
  const ContactUS({Key? key}) : super(key: key);

  @override
  State<ContactUS> createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  @override
  void initState() {
    homeData.loadAd();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeData.loadAd();
    loadAppOpen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.grayy,
        title: CustomText(text: "للتواصل وتقديم الاقتراحات", fontSize: 22.sp),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Transform.flip(
                flipX: true,
                child: const Icon(
                  Icons.arrow_back_ios_sharp,
                  color: AppColors.white,
                ),
              ))
        ],
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
      body: Column(
        children: [
          Expanded(
            child: Column(
              // padding: const EdgeInsets.all(16),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: CustomText(text: "آهلا بيك يا صديقي", fontSize: 16),
                ),
                const CustomText(text: "يمكنك محادثتنا من خلال", fontSize: 16),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    String url = "https://wa.me/+201149504892";

                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    }
                  },
                  child: const CustomText(
                    text: "الواتس اب",
                    fontSize: 16,
                    color: AppColors.green,
                    underline: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.mainColor,
            child: const CustomText(
              text:
                  "التطبيق لا ينتمي للأستاذ يحى عزام ولكن لمطورية فقط, ورقم الواتس المرفق للاقترحات والشكاوى",
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
