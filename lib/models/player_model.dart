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
  });

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
      };
}
