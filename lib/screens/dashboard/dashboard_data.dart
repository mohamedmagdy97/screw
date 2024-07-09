import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:screw_calc/components/custom_button.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/components/text_filed_custom.dart';
import 'package:screw_calc/cubits/generic_cubit/generic_cubit.dart';
import 'package:screw_calc/helpers/ad_manager.dart';
import 'package:screw_calc/models/game_model.dart';
import 'package:screw_calc/models/player_model.dart';
import 'package:screw_calc/utility/app_theme.dart';
import 'package:screw_calc/utility/local_store.dart';
import 'package:screw_calc/utility/local_storge_key.dart';
import 'package:screw_calc/utility/utilities.dart';
import 'package:screw_calc/utility/validation_form.dart';

class DashboardData {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  init() {
    hideMarquee.update(data: false);
    getSavedGames();
    // loadNativeAdvanced();
  }

  checkAllGwPlayed(int gw, List<PlayerModel> players, int index) {
    print('ddddddddd=gw1=${players[index].gw1!.isNotEmpty}');
    print('ddddddddd=gw2=${players[index].gw2!.isNotEmpty}');
    print('ddddddddd=gw3=${players[index].gw3!.isNotEmpty}');
    print('ddddddddd=gw4=${players[index].gw4!.isNotEmpty}');
    print('ddddddddd=gw5=${players[index].gw5!.isNotEmpty}');
    print('ddddddddd==$gw');
    print(
        'dd=1=${players.where((element) => element.gw1!.isEmpty).toList().length > 1}');
    print(
        'dd=2=${players.where((element) => element.gw2!.isEmpty).toList().length > 1}');
    print(
        'dd=3=${players.where((element) => element.gw3!.isEmpty).toList().length > 1}');
    print(
        'dd=4=${players.where((element) => element.gw4!.isEmpty).toList().length > 1}');
    print(
        'dd=5=${players.where((element) => element.gw5!.isEmpty).toList().length > 1}');

    if (gw == 1) {
      if (players[index].gw1!.isNotEmpty != false &&
          (players.where((element) => element.gw1!.isEmpty).toList().length >
                  1 !=
              false)) {
        print('ssssss  lol 1');
      }
    } else if (gw == 2) {
      if (players[index].gw2!.isNotEmpty != false &&
          (players.where((element) => element.gw2!.isEmpty).toList().length >
                  1 !=
              false)) {
        print('ssssss  lol 2');
      }
    } else if (gw == 3) {
      if (players[index].gw3!.isNotEmpty != false &&
          (players.where((element) => element.gw3!.isEmpty).toList().length >
                  1 !=
              false)) {
        print('ssssss  lol 3');
      }
    } else if (gw == 4) {
      if (players[index].gw4!.isNotEmpty != false &&
          (players.where((element) => element.gw4!.isEmpty).toList().length >
                  1 !=
              false)) {
        print('ssssss  lol 4');
      }
    } else if (gw == 5) {
      if (players[index].gw5!.isNotEmpty != false &&
          (players.where((element) => element.gw5!.isEmpty).toList().length >
                  1 !=
              false)) {
        print('ssssss  lol 5');
      }
    }

    // if(gw ==1){
    //   if(
    //   players.where((element) => element.gw1!.isEmpty).toList().length >1){
    //     print('lolllllll11 11');
    //
    //     return;
    //   }
    // }else if(gw ==2){
    //   if(
    //   players.where((element) => element.gw2!.isEmpty).toList().length >1){
    //     print('lolllllll11 22');
    //
    //     return;
    //   }
    // } else if(gw ==3){
    //   if(
    //   players.where((element) => element.gw2!.isEmpty).toList().length >1){
    //     print('lolllllll11 33');
    //
    //     return;
    //   }
    // }else if(gw ==4){
    //   if(
    //   players.where((element) => element.gw2!.isEmpty).toList().length >1){
    //     print('lolllllll11 44');
    //
    //     return;
    //   }
    // }else if(gw ==5){
    //   if(
    //   players.where((element) => element.gw2!.isEmpty).toList().length >1){
    //     print('lolllllll11 55');
    //
    //     return;
    //   }
    // }
    /*switch (gw) {
      // case 1:
      //   if ((players.where((element) => element.gw1!.isNotEmpty).toList().length !=
      //       players.length)) {
      //
      //     return;
      //   }
      //   break;
      case 2:
        if ((players
                .where((element) => element.gw2!.isNotEmpty)
                .toList()
                .length <
            players.length)) {
          print(
              'looooool= case 2 = you will not add after Add all players values');
          return;
        }
        break;
      case 3:
        if ((players
                .where((element) => element.gw3!.isNotEmpty)
                .toList()
                .length <
            players.length)) {
          print(
              'looooool= case 3 ==you will not add after Add all players values');
          return;
        }
        break;
      case 4:
        if ((players
                .where((element) => element.gw4!.isNotEmpty)
                .toList()
                .length ==
            players.length)) {
          print(
              'looooool= case 4 ==you will not add after Add all players values');
          return;
        }
        break;
      case 5:
        if ((players
                .where((element) => element.gw5!.isNotEmpty)
                .toList()
                .length ==
            players.length)) {
          print('looooool=you will not add after Add all players values');
          return;
        }
        break;
    }*/
  }

  addValue(context, {required PlayerModel player}) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Directionality(
                textDirection: TextDirection.rtl,
                child: CustomText(
                  text: 'نتيجة الاعب ${player.name} في الجولة ',
                  fontSize: 14.sp,
                  textAlign: TextAlign.center,
                  color: AppColors.black,
                ),
              ),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      controller: controller,
                      hintText: '',
                      labelText: '',
                      containtPaddingRight: 0,
                      inputType: TextInputType.number,
                      fillColor: Colors.white,
                      textColor: Colors.black,
                      fillBorderColor: AppColors.grayy,
                      textFieldVaidType: TextFieldValidatorType.Number,
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'التالي',
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        Navigator.pop(context);
                        if (player.gw1!.isEmpty) {
                          player.gw1 = controller.text;

                          player.total =
                              (int.parse(player.gw1.toString())).toString();
                        } else if (player.gw2!.isEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw2 = controller.text;

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()))
                              .toString();
                        } else if (player.gw3!.isEmpty &&
                            player.gw2!.isNotEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw3 = controller.text;

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()) +
                                  int.parse(player.gw3.toString()))
                              .toString();
                        } else if (player.gw4!.isEmpty &&
                            player.gw3!.isNotEmpty &&
                            player.gw2!.isNotEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw4 = controller.text;

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()) +
                                  int.parse(player.gw3.toString()) +
                                  int.parse(player.gw4.toString()))
                              .toString();
                        } else if (player.gw5!.isEmpty &&
                            player.gw4!.isNotEmpty &&
                            player.gw3!.isNotEmpty &&
                            player.gw2!.isNotEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw5 = controller.text;

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()) +
                                  int.parse(player.gw3.toString()) +
                                  int.parse(player.gw4.toString()) +
                                  int.parse(player.gw5.toString()))
                              .toString();
                        }

                        controller.clear();
                      },
                    ),
                    const SizedBox(height: 16),
                    // if (player.gw5!.isEmpty &&
                    //     player.gw4!.isNotEmpty &&
                    //     player.gw3!.isNotEmpty &&
                    //     player.gw2!.isNotEmpty &&
                    //     player.gw1!.isNotEmpty)
                    CustomButton(
                      text: ' 2 x آحسب النتيجه ',
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        Navigator.pop(context);
                        if (player.gw1!.isEmpty) {
                          player.gw1 =
                              (int.parse(controller.text.toString()) * 2)
                                  .toString();

                          player.total =
                              (int.parse(player.gw1.toString())).toString();
                        } else if (player.gw2!.isEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw2 =
                              (int.parse(controller.text.toString()) * 2)
                                  .toString();

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()))
                              .toString();
                        } else if (player.gw3!.isEmpty &&
                            player.gw2!.isNotEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw3 =
                              (int.parse(controller.text.toString()) * 2)
                                  .toString();

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()) +
                                  int.parse(player.gw3.toString()))
                              .toString();
                        } else if (player.gw4!.isEmpty &&
                            player.gw3!.isNotEmpty &&
                            player.gw2!.isNotEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw4 =
                              (int.parse(controller.text.toString()) * 2)
                                  .toString();

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()) +
                                  int.parse(player.gw3.toString()) +
                                  int.parse(player.gw4.toString()))
                              .toString();
                        } else if (player.gw5!.isEmpty &&
                            player.gw4!.isNotEmpty &&
                            player.gw3!.isNotEmpty &&
                            player.gw2!.isNotEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw5 =
                              (int.parse(controller.text.toString()) * 2)
                                  .toString();

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()) +
                                  int.parse(player.gw3.toString()) +
                                  int.parse(player.gw4.toString()) +
                                  (int.parse(player.gw5.toString())))
                              .toString();
                        }

                        controller.clear();
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: ' سكرو (0) ',
                      onPressed: () {
                        controller.text = "0";
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        Navigator.pop(context);
                        if (player.gw1!.isEmpty) {
                          player.gw1 = "0";

                          player.total =
                              (int.parse(player.gw1.toString())).toString();
                        } else if (player.gw2!.isEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw2 = "0";

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()))
                              .toString();
                        } else if (player.gw3!.isEmpty &&
                            player.gw2!.isNotEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw3 = "0";

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()) +
                                  int.parse(player.gw3.toString()))
                              .toString();
                        } else if (player.gw4!.isEmpty &&
                            player.gw3!.isNotEmpty &&
                            player.gw2!.isNotEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw4 = "0";

                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()) +
                                  int.parse(player.gw3.toString()) +
                                  int.parse(player.gw4.toString()))
                              .toString();
                        } else if (player.gw5!.isEmpty &&
                            player.gw4!.isNotEmpty &&
                            player.gw3!.isNotEmpty &&
                            player.gw2!.isNotEmpty &&
                            player.gw1!.isNotEmpty) {
                          player.gw5 = "0";
                          player.total = (int.parse(player.gw1.toString()) +
                                  int.parse(player.gw2.toString()) +
                                  int.parse(player.gw3.toString()) +
                                  int.parse(player.gw4.toString()) +
                                  (int.parse(player.gw5.toString())))
                              .toString();
                        }

                        controller.clear();
                      },
                    ),

                    const SizedBox(height: 16),
                    CustomText(
                      text: "انتبه لا يمكن التعديل على النتيجة",
                      fontSize: 14.sp,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ),
            ));
  }

  List<GameModel> listGames = [];
  GenericCubit<List<GameModel>> jobsCubit = GenericCubit<List<GameModel>>();
  GenericCubit<bool> hideMarquee = GenericCubit<bool>(data: false);

  getSavedGames() async {
    String? res = await AppLocalStore.getString(LocalStoreNames.gamesHistory);

    final List<dynamic> jsonData = jsonDecode(res ?? '[]');

    listGames = jsonData.map<GameModel>((jsonItem) {
      return GameModel.fromJson(jsonItem);
    }).toList();

    jobsCubit.update(data: listGames.toList());
  }

  saveGame(List<PlayerModel> listPlayers, context) {
    if (listPlayers.last.gw5 != null &&
        listPlayers.last.gw5!.isNotEmpty &&
        listPlayers.first.gw5 != null &&
        listPlayers.first.gw5!.isNotEmpty) {
      listGames.add(GameModel(game: listPlayers));
      addGameToDB();
      Utilities().customSnackBarTerms(context, txt: "تم حفظ الجولة");
      AdManager().loadRewardedInterstitialAd();
      Navigator.pop(context);
      // AdManager().loadInterstitialAd();
    } else {
      Utilities().customSnackBarTerms(context,
          txt: "لحفظ النتائج يجب ادخال جميع الجولات");
    }
  }

  addGameToDB() async {
    AppLocalStore.setString(
        LocalStoreNames.gamesHistory, jsonEncode(listGames));
  }

  // ca-app-pub-2846618561973841/8361071637

  NativeAd? nativeAd;
  GenericCubit<bool> isLoadedCubit = GenericCubit(data: false);
  bool isLoaded = false;

  loadNativeAdvanced() {
    nativeAd = NativeAd(
        request: const AdRequest(),
        factoryId: "listTile",
        adUnitId: "ca-app-pub-2846618561973841/8361071637",
        listener: NativeAdListener(
            onAdLoaded: (ads) => isLoadedCubit.update(data: true),
            onAdFailedToLoad: (add, error) {
              add.dispose();
              log("Native Advance Message Error===========$error");
            }),

        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
            // Required: Choose a template.
            templateType: TemplateType.medium,
            // Optional: Customize the ad's style.
            mainBackgroundColor: Colors.purple,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.cyan,
                backgroundColor: Colors.red,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.red,
                backgroundColor: Colors.cyan,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.green,
                backgroundColor: Colors.black,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.brown,
                backgroundColor: Colors.amber,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();

    // nativeAd!.load();
  }
}
