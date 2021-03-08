import 'dart:convert';

CommonData commonDataFromJson(String str) =>
    CommonData.fromJson(json.decode(str));

String commonDataToJson(CommonData data) => json.encode(data.toJson());

class CommonData {
  CommonData({
    this.id,
    this.name,
    this.color,
    this.isAvailable = true,
  });

  int id;
  String name;
  String color;
  bool isAvailable;

  factory CommonData.fromJson(Map<String, dynamic> json) => CommonData(
        id: json["id"],
        name: json["name"],
        color: json["color"],
        isAvailable: json["isAvailable"] == 0 ? false : true,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
        "isAvailable": isAvailable ? 1 : 0,
      };
}
