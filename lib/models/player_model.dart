class PlayerModel {
  int? id;
  String? name;
  String? gw1;
  String? gw2;
  String? gw3;
  String? gw4;
  String? gw5;
  String? total;
  bool? isActive;
  bool? isFavorite;
  List<String?> scores;
  List<int> roundScores;

  PlayerModel({
    this.id,
    this.name,
    this.gw1 = "",
    this.gw2 = "",
    this.gw3 = "",
    this.gw4 = "",
    this.gw5 = "",
    this.total = "0",
    this.isActive = false,
    this.isFavorite = false,
    int rounds = 5,
  })  : scores = List.filled(5, null),
        roundScores = List.generate(rounds, (_) => 0);

  int get totalScore => roundScores.reduce((a, b) => a + b);

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        id: json["id"],
        name: json["name"],
        gw1: json["gw1"] ?? "",
        gw2: json["gw2"] ?? "",
        gw3: json["gw3"] ?? "",
        gw4: json["gw4"] ?? "",
        gw5: json["gw5"] ?? "",
        total: json["total"] ?? "0",
        isActive: json["isActive"] ?? false,
        isFavorite: json["isFavorite"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gw1": gw1,
        "gw2": gw2,
        "gw3": gw3,
        "gw4": gw4,
        "gw5": gw5,
        "total": total,
        "isActive": isActive ?? false,
        "isFavorite": isFavorite ?? false,
      };

  // New method to get round score dynamically
  String getRoundScore(int round) {
    switch (round) {
      case 1:
        return gw1 ?? "";
      case 2:
        return gw2 ?? "";
      case 3:
        return gw3 ?? "";
      case 4:
        return gw4 ?? "";
      case 5:
        return gw5 ?? "";
      default:
        return "";
    }
  }

  // Get score of a specific round
  String? getRoundTeamScore(int round) {
    return scores[round - 1]; // Index is round - 1 since lists start from 0
  }

  // Update score for a specific round
  // void updateScore(int round, String score) {
  //   scores[round - 1] = score;
  //   total = scores
  //       .fold<int>(0, (sum, score) => sum + (int.tryParse(score ?? "0") ?? 0))
  //       .toString();
  // }

  void updateScore(int round, int score) {
    if (round >= 0 && round < roundScores.length) {
      roundScores[round] = score;
    }
  }
}

class TeamModel {
  final String name;
  final PlayerModel player1;
  final PlayerModel player2;

  TeamModel({required this.name, required this.player1, required this.player2});

  int get totalTeamScore => player1.totalScore + player2.totalScore;
}
