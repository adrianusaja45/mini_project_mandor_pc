// To parse this JSON data, do
//
//     final caseModel = caseModelFromJson(jsonString);

import 'dart:convert';

List<CaseModel> caseModelFromJson(String str) =>
    List<CaseModel>.from(json.decode(str).map((x) => CaseModel.fromJson(x)));

String caseModelToJson(List<CaseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CaseModel {
  CaseModel({
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
    this.isSmallBusiness,
    this.deal,
    this.availability,
    this.coupon,
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
  bool? isSmallBusiness;
  Deal? deal;
  Availability? availability;
  Coupon? coupon;

  factory CaseModel.fromJson(Map<String, dynamic> json) => CaseModel(
        id: json["id"],
        title: json["title"],
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
        isSmallBusiness: json["is_small_business"],
        deal: json["deal"] == null ? null : Deal.fromJson(json["deal"]),
        availability: json["availability"] == null
            ? null
            : Availability.fromJson(json["availability"]),
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
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
        "is_small_business": isSmallBusiness,
        "deal": deal?.toJson(),
        "availability": availability?.toJson(),
        "coupon": coupon?.toJson(),
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

enum Name { COMPUTER_CASES }

final nameValues = EnumValues({"Computer Cases": Name.COMPUTER_CASES});

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

class Deal {
  Deal({
    required this.link,
    required this.badgeText,
  });

  String link;
  String badgeText;

  factory Deal.fromJson(Map<String, dynamic> json) => Deal(
        link: json["link"],
        badgeText: json["badge_text"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "badge_text": badgeText,
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
