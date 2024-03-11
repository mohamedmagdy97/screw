import 'package:screw_calc/models/player_model.dart';

class GameModel {
  List<PlayerModel>? game;

  GameModel({this.game});

  GameModel.fromJson(Map<String, dynamic> json) {
    if (json['game'] != null) {
      game = <PlayerModel>[];
      json['game'].forEach((v) {
        game!.add(PlayerModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (game != null) {
      data['game'] = game!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
