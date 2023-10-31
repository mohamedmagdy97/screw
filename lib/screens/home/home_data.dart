import 'package:flutter/material.dart';
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

  init() {
    List.generate(
        5,
        (index) => listCubit.state.data!.add(
            Item(key: (index + 2), value: "${index + 2}", isActive: false)));

    listCubit.state.data!.first.isActive = true;
    listCubit.update(data: listCubit.state.data!);
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
}
