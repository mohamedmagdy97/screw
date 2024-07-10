import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/screens/contact_us/contact_us.dart';
import 'package:screw_calc/screens/history/history.dart';
import 'package:screw_calc/screens/rules/rules_screen.dart';
import 'package:screw_calc/utility/app_theme.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.7.sw,
      padding: EdgeInsets.only(top: 60.h, bottom: 54.h),
      child: SafeArea(
        child: Drawer(
          backgroundColor: AppColors.opacity_1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Image.asset("assets/icons/icon.png", height: 0.15.sh),

                  // Icon(Icons.gavel_sharp,
                  //     size: 50, color: Colors.white),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: CustomText(text: "آهلا بيك يا صديقي", fontSize: 16),
                ),
                const Divider(endIndent: 10, indent: 10),
                ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HistoryScreen()),
                  ),
                  title: const CustomText(
                    text: "الجولات السابقة",
                    fontSize: 16,
                    textAlign: TextAlign.end,
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RulesScreen()),
                  ),
                  title: const CustomText(
                    text: "قوانين اللعبة",
                    fontSize: 16,
                    textAlign: TextAlign.end,
                  ),
                ),
                /*  ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ShowVideo()),
                  ),
                  title: const CustomText(
                    text: "فيديو شرح اللعبة",
                    fontSize: 16,
                    textAlign: TextAlign.end,
                  ),
                ),*/
                ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ContactUS()),
                  ),
                  title: const CustomText(
                    text: "للاقتراحات والتواصل معنا ",
                    fontSize: 16,
                    textAlign: TextAlign.end,
                  ),
                ),
                // ListTile(
                //   title: CustomText(
                //     text: "لمعرفه اماكن شراء اللعبه",
                //     fontSize: 16,
                //     textAlign: TextAlign.end,
                //   ),
                // ),
                const Spacer(),
                const CustomText(
                  text: "version 1.0.7",
                  fontSize: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
