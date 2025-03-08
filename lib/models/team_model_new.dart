import 'package:screw_calc/models/player_model.dart';

class Team {
  final String name;
  final PlayerModel playerOne;
  final PlayerModel playerTwo;

  Team({
    required this.name,
    required this.playerOne,
    required this.playerTwo,
  });

  int get totalScore =>
      (int.tryParse(playerOne.total ?? '0') ?? 0) +
      (int.tryParse(playerTwo.total ?? '0') ?? 0);
}
