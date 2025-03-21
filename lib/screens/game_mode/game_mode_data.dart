import 'dart:io';
import 'package:flutter/material.dart';
import 'package:screw_calc/cubits/generic_cubit/generic_cubit.dart';
import 'package:screw_calc/models/item.dart';
import 'package:screw_calc/screens/home/home.dart';
import 'package:screw_calc/utility/Enums.dart';
import 'package:screw_calc/utility/utilities.dart';

class GameModeData {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  GenericCubit<List<Item>> listCubit = GenericCubit<List<Item>>(data: []);
  DateTime? currentBackPressTime;

  init() async {
    List<Item> list = [
      Item(isActive: true, key: 0, value: "كلاسيك\n (فردي)"),
      Item(isActive: false, key: 1, value: "صاحب صاحبه\n (زوجي)"),

      // Item(isActive: false,key: 2,value: "بينج بونج"),
    ];
    listCubit.update(data: list);
  }

  onSelect(context, index) {
    if (index == 1) {
      ModeClass.mode = GameMode.friendly;
      // return Utilities()
      //     .customSnackBarTerms(context, txt: "قريبا سيتم الاضافه");
    } else {
      ModeClass.mode = GameMode.classic;
    }
    listCubit.state.data!.map((e) => e.isActive = false).toList();
    listCubit.update(data: listCubit.state.data!);

    listCubit.state.data![index].isActive = true;
    listCubit.update(data: listCubit.state.data!);
  }

  goToHome(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MyHomePage(
            // builder: (_) => const DashboardChatGPT(
            /*gameMode: listCubit.state.data!
                  .where((e) => e.isActive == true)
                  .toList()
                  .first
                  .key ??
              0,*/
            ),
      ),
    );
  }

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

  void showSnackBar(String content, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }
}
