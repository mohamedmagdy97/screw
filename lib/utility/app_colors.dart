part of 'app_theme.dart';

class AppColors {
  // static const Color mainColor = Color(0xffBB86FC);
  static const Color mainColor = Colors.purple;
  static const Color mainColorAccent = Colors.purpleAccent;
  static const Color mainColorLight=  Color(0xFFE583FC);
  // static const Color mainColorLight =Colors.purple;
  static const Color mainColorLight2 = Color(0xffe6edf3);
  static const Color mainColorLightOpacity = Color(0xffE6EDF3);
  static const Color secondaryColor = Color(0xffFF782C);
  static const Color secondaryColorLight = Color(0xffF49864);
  static const Color secondaryColorLight2 = Color(0xfff6ab80);
  static const Color secondaryColorOpacity = Color(0xffFFD9C4);
  static const Color textColorTitle = Color(0xff122A41);
  static const Color textColorSubTitle = Color(0xff242D34);
  static const Color textColor = Color(0xff323436);
  static const Color textColorSubTitleIntro = Color(0xff5E6163);
  static const Color textColorHint = Color(0xffA4A4A5);
  static const Color bgAppBar = Color(0xffEDEDED);
  static const Color bgNavBar = Color(0xffE1E1E1);
  static const Color bgScreen = Color(0xffF9F9F9);
  static const Color grayy = Color(0xff303030);
  static const Color bg = Color(0xff121212);

  static const Color redDark = Color(0xffE11414);
  static const Color green = Color(0xff44CE00);
  static const Color grey = Color(0xffd4d4d4);
  static const Color greyC9C9C9 = Color(0xffC9C9C9);
  static const Color greyEEEEEE = Color(0xffEEEEEE);
  static const Color greyE8E8E8 = Color(0xffE8E8E8);
  static const Color greyB0B0B0 = Color(0xffB0B0B0);
  static const Color greyBFBDBD = Color(0xffBFBDBD);
  static const Color orangeF8A500 = Color(0xffF8A500);
  static const Color opacity_1 = Color(0xffad9cb8);
  static const Color cardColor = Color(0xffdeeaff);
  static const Color cardColor3 = Color(0xff4C2563);
  static const Color cardColor4 = Color(0xff8a9d2a);
  static const Color bluecolor = Color(0XFF2196f3);
  static const Color cancelledColor = red; // Color(0XFFb5b5b5);
  static const Color textBlack = Color(0XFF505050);
  static const Color textBox = Color(0XFFE9E9E9);

  static statusColor({required dynamic statusCode}) {
    switch (statusCode.toString()) {
      case '100000009': // Ticket: closed tickets
      case '0': // Visit: opened visits
      case '1': // Visit: Start visits, Individual Request: New
      case '5': // Visit: Reparation visits
      case '9': // Visit: Refund is under way
      case '13': // Visit: arrived visits
      case '14': // Visit: Arrive to Deliver
        return AppColors.cardColor3;
      case '100000000': // Ticket: opened tickets // Individual Request: Approved
      case '100000014': // Ticket: opened tickets
      case '2': // Visit: closed visits
        return cardColor4;
      case '7': // Visit: Not Finished - Internal Problem
      case '8': // Visit: تم رد المبلغ
      case '3': // Visit: Finished - Customer not reply/found
      case '6': // Visit: finished - wrong location
      case '10': // Visit: Finished - no woman found
      case '11': // Visit: Finished - refuses to receive
        return AppColors.red;
      case '4': // Visit: Postponded
      case '12': // Visit: تم الغاء الزيارة المجانية
      case '16': // Visit: Canceled-RefusedContract
      case '100000001': // Individual Request: Canceled
        return AppColors.cancelledColor;
      default:
        return AppColors.red;
    }
  }

  static const Color fillColor = Color(0xffcdc6d2);
  static const Color fillColorBackGround = Color(0xffcdc6d2);
  static const Color unSelectedDayFontColor = Color(0xff929497);
  static const Color amber = Color(0xffFFC446);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color red = Color(0xffFF0000);

  static const Color colorSelectedVisit = Colors.red;
  static const Color invalidPoint = Color(0xfff49989);
  static const Color colorTableBgone = Color(0xfff3f3f3);
}
