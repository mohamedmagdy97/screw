class Item {
  int? key;
  String? value;
  bool? isActive;

  Item({this.key, this.value, this.isActive = false});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        key: json["key"],
        value: json["value"].toString(),
        isActive: json["isActive"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
        "isActive": isActive ?? false,
      };
}
