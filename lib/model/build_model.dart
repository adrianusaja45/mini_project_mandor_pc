// To parse this JSON data, do
//
//     final savedBuild = savedBuildFromJson(jsonString);

import 'dart:convert';

List<SavedBuild> savedBuildFromJson(String str) =>
    List<SavedBuild>.from(json.decode(str).map((x) => SavedBuild.fromJson(x)));

String savedBuildToJson(List<SavedBuild> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SavedBuild {
  int? id;
  String? titleBuild;
  List<BuildItem>? buildItems;

  SavedBuild({
    this.id,
    this.titleBuild,
    this.buildItems,
  });

  factory SavedBuild.fromJson(Map<String, dynamic> json) => SavedBuild(
        id: json["id"],
        titleBuild: json["title_build"],
        buildItems: json["build_items"] == null
            ? []
            : List<BuildItem>.from(
                json["build_items"]!.map((x) => BuildItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title_build": titleBuild,
        "build_items": buildItems == null
            ? []
            : List<dynamic>.from(buildItems!.map((x) => x.toJson())),
      };
}

class BuildItem {
  int? idPart;
  String? title;
  String? image;
  Price? price;

  BuildItem({
    this.idPart,
    this.title,
    this.image,
    this.price,
  });

  factory BuildItem.fromJson(Map<String, dynamic> json) => BuildItem(
        idPart: json["id_part"],
        title: json["title"],
        image: json["image"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
      );

  Map<String, dynamic> toJson() => {
        "id_part": idPart,
        "title": title,
        "image": image,
        "price": price?.toJson(),
      };
}

class Price {
  String? symbol;
  double? value;
  String? currency;
  String? raw;

  Price({
    this.symbol,
    this.value,
    this.currency,
    this.raw,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        symbol: json["symbol"],
        value: json["value"]?.toDouble(),
        currency: json["currency"],
        raw: json["raw"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "value": value,
        "currency": currency,
        "raw": raw,
      };
}

enum Currency { USD }

final currencyValues = EnumValues({"USD": Currency.USD});

enum Symbol { EMPTY }

final symbolValues = EnumValues({"\u0024": Symbol.EMPTY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
