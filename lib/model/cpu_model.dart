// To parse this JSON data, do
//
//     final cpuModel = cpuModelFromJson(jsonString);

import 'dart:convert';

List<CpuModel> cpuModelFromJson(String str) =>
    List<CpuModel>.from(json.decode(str).map((x) => CpuModel.fromJson(x)));

String cpuModelToJson(List<CpuModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CpuModel {
  CpuModel({
    required this.id,
    required this.title,
    required this.asin,
    required this.link,
    required this.categories,
    required this.image,
    this.amazonsChoice,
    this.isPrime,
    required this.rating,
    required this.ratingsTotal,
    required this.price,
    this.availability,
  });

  int id;
  String title;
  String asin;
  String link;
  List<Category> categories;
  String image;
  AmazonsChoice? amazonsChoice;
  bool? isPrime;
  double? rating;
  int? ratingsTotal;
  Price? price;
  Availability? availability;

  factory CpuModel.fromJson(Map<String, dynamic> json) => CpuModel(
        id: json["id"],
        title: json["title"]!,
        asin: json["asin"],
        link: json["link"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        image: json["image"],
        amazonsChoice: json["amazons_choice"] == null
            ? null
            : AmazonsChoice.fromJson(json["amazons_choice"]),
        isPrime: json["is_prime"],
        rating: json["rating"]?.toDouble(),
        ratingsTotal: json["ratings_total"],
        price: Price.fromJson(json["price"]),
        availability: json["availability"] == null
            ? null
            : Availability.fromJson(json["availability"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "asin": asin,
        "link": link,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "image": image,
        "amazons_choice": amazonsChoice?.toJson(),
        "is_prime": isPrime,
        "rating": rating,
        "ratings_total": ratingsTotal,
        "price": price!.toJson(),
        "availability": availability?.toJson(),
      };
}

class AmazonsChoice {
  AmazonsChoice({
    required this.link,
    required this.keywords,
  });

  String link;
  String keywords;

  factory AmazonsChoice.fromJson(Map<String, dynamic> json) => AmazonsChoice(
        link: json["link"],
        keywords: json["keywords"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "keywords": keywords,
      };
}

class Availability {
  Availability({
    required this.raw,
  });

  String raw;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        raw: json["raw"],
      );

  Map<String, dynamic> toJson() => {
        "raw": raw,
      };
}

class Category {
  Category({
    required this.name,
    required this.id,
  });

  CategoryName name;
  String id;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: categoryNameValues.map[json["name"]]!,
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": categoryNameValues.reverse[name],
        "id": id,
      };
}

enum CategoryName { COMPUTER_CPU_PROCESSORS }

final categoryNameValues = EnumValues(
    {"Computer CPU Processors": CategoryName.COMPUTER_CPU_PROCESSORS});

class Price {
  Price({
    required this.symbol,
    required this.value,
    required this.currency,
    required this.raw,
    this.name,
    this.isPrimary,
    this.asin,
    this.link,
  });

  Symbol symbol;
  double value;
  Currency currency;
  String raw;
  PriceName? name;
  bool? isPrimary;
  String? asin;
  String? link;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        symbol: symbolValues.map[json["symbol"]]!,
        value: json["value"]?.toDouble(),
        currency: currencyValues.map[json["currency"]]!,
        raw: json["raw"],
        name: priceNameValues.map[json["name"]]!,
        isPrimary: json["is_primary"],
        asin: json["asin"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbolValues.reverse[symbol],
        "value": value,
        "currency": currencyValues.reverse[currency],
        "raw": raw,
        "name": priceNameValues.reverse[name],
        "is_primary": isPrimary,
        "asin": asin,
        "link": link,
      };
}

enum Currency { USD }

final currencyValues = EnumValues({"USD": Currency.USD});

enum PriceName { PRIMARY }

final priceNameValues = EnumValues({"Primary": PriceName.PRIMARY});

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
