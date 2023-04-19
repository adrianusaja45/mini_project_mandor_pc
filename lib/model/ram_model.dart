// To parse this JSON data, do
//
//     final ramModel = ramModelFromJson(jsonString);

import 'dart:convert';

List<RamModel> ramModelFromJson(String str) =>
    List<RamModel>.from(json.decode(str).map((x) => RamModel.fromJson(x)));

String ramModelToJson(List<RamModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RamModel {
  RamModel({
    required this.id,
    required this.title,
    required this.asin,
    required this.link,
    required this.categories,
    required this.image,
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
  bool? isPrime;
  double? rating;
  int? ratingsTotal;
  Price? price;
  Availability? availability;

  factory RamModel.fromJson(Map<String, dynamic> json) => RamModel(
        id: json["id"],
        title: json["title"]!,
        asin: json["asin"],
        link: json["link"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        image: json["image"],
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
        "is_prime": isPrime,
        "rating": rating,
        "ratings_total": ratingsTotal,
        "price": price!.toJson(),
        "availability": availability?.toJson(),
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

enum Name { COMPUTER_MEMORY }

final nameValues = EnumValues({"Computer Memory": Name.COMPUTER_MEMORY});

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
  String? name;
  bool? isPrimary;
  String? asin;
  String? link;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        symbol: symbolValues.map[json["symbol"]]!,
        value: json["value"]?.toDouble(),
        currency: currencyValues.map[json["currency"]]!,
        raw: json["raw"],
        name: json["name"],
        isPrimary: json["is_primary"],
        asin: json["asin"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbolValues.reverse[symbol],
        "value": value,
        "currency": currencyValues.reverse[currency],
        "raw": raw,
        "name": name,
        "is_primary": isPrimary,
        "asin": asin,
        "link": link,
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
