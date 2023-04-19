// To parse this JSON data, do
//
//     final cpuCoolerModel = cpuCoolerModelFromJson(jsonString);

import 'dart:convert';

List<CpuCoolerModel> cpuCoolerModelFromJson(String str) =>
    List<CpuCoolerModel>.from(
        json.decode(str).map((x) => CpuCoolerModel.fromJson(x)));

String cpuCoolerModelToJson(List<CpuCoolerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CpuCoolerModel {
  CpuCoolerModel({
    required this.id,
    required this.title,
    required this.asin,
    required this.link,
    required this.categories,
    required this.image,
    required this.rating,
    required this.ratingsTotal,
    required this.price,
    this.isPrime,
    this.availability,
    this.isSmallBusiness,
    this.coupon,
  });

  int id;
  String title;
  String asin;
  String link;
  List<Category> categories;
  String image;
  double? rating;
  int? ratingsTotal;
  Price? price;
  bool? isPrime;
  Availability? availability;
  bool? isSmallBusiness;
  Coupon? coupon;

  factory CpuCoolerModel.fromJson(Map<String, dynamic> json) => CpuCoolerModel(
        id: json["id"],
        title: json["title"]!,
        asin: json["asin"],
        link: json["link"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        image: json["image"],
        rating: json["rating"]?.toDouble(),
        ratingsTotal: json["ratings_total"],
        price: Price.fromJson(json["price"]),
        isPrime: json["is_prime"],
        availability: json["availability"] == null
            ? null
            : Availability.fromJson(json["availability"]),
        isSmallBusiness: json["is_small_business"],
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "asin": asin,
        "link": link,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "image": image,
        "rating": rating,
        "ratings_total": ratingsTotal,
        "price": price!.toJson(),
        "is_prime": isPrime,
        "availability": availability?.toJson(),
        "is_small_business": isSmallBusiness,
        "coupon": coupon?.toJson(),
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

  Name name;
  String id;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: nameValues.map[json["name"]]!,
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "id": id,
      };
}

enum Name { COMPUTER_CPU_COOLING_FANS }

final nameValues =
    EnumValues({"Computer CPU Cooling Fans": Name.COMPUTER_CPU_COOLING_FANS});

class Coupon {
  Coupon({
    required this.badgeText,
    required this.text,
  });

  String badgeText;
  String text;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        badgeText: json["badge_text"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "badge_text": badgeText,
        "text": text,
      };
}

class Price {
  Price({
    required this.symbol,
    required this.value,
    required this.currency,
    required this.raw,
    this.asin,
    this.link,
    this.name,
    this.isPrimary,
  });

  Symbol symbol;
  double value;
  Currency currency;
  String raw;
  String? asin;
  String? link;
  String? name;
  bool? isPrimary;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        symbol: symbolValues.map[json["symbol"]]!,
        value: json["value"]?.toDouble(),
        currency: currencyValues.map[json["currency"]]!,
        raw: json["raw"],
        asin: json["asin"],
        link: json["link"],
        name: json["name"],
        isPrimary: json["is_primary"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbolValues.reverse[symbol],
        "value": value,
        "currency": currencyValues.reverse[currency],
        "raw": raw,
        "asin": asin,
        "link": link,
        "name": name,
        "is_primary": isPrimary,
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
