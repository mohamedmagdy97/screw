import 'package:flutter/cupertino.dart';
import 'package:screw_calc/cubits/generic_cubit/generic_cubit.dart';
import 'package:screw_calc/models/item.dart';

class HomeData {
  GenericCubit<List<Item>> listCubit = GenericCubit<List<Item>>(data: []);

  final TextEditingController playerOne = TextEditingController();
  final TextEditingController playerTwo = TextEditingController();
  final TextEditingController playerThree = TextEditingController();
  final TextEditingController playerFour = TextEditingController();
  final TextEditingController playerFive = TextEditingController();
  final TextEditingController playerSix = TextEditingController();

  init() {
    List.generate(
        5,
        (index) => listCubit.state.data!.add(
            Item(key: (index + 2), value: "${index + 2}", isActive: false)));

    listCubit.update(data: listCubit.state.data!.reversed.toList());
  }

  onSelect(index) {
    listCubit.state.data!.map((e) => e.isActive = false).toList();
    listCubit.update(data: listCubit.state.data!);

    listCubit.state.data![index].isActive = true;
    listCubit.update(data: listCubit.state.data!);
  }
}
