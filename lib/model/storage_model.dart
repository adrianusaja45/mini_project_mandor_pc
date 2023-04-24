// To parse this JSON data, do
//
//     final storageModel = storageModelFromJson(jsonString);

import 'dart:convert';

List<StorageModel> storageModelFromJson(String str) => List<StorageModel>.from(
    json.decode(str).map((x) => StorageModel.fromJson(x)));

String storageModelToJson(List<StorageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StorageModel {
  StorageModel({
    required this.id,
    required this.title,
    required this.asin,
    required this.link,
    required this.categories,
    required this.image,
    this.isPrime,
    this.rating,
    this.ratingsTotal,
    required this.price,
    this.amazonsChoice,
    this.availability,
    this.bestseller,
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
  Price price;
  AmazonsChoice? amazonsChoice;
  Availability? availability;
  Bestseller? bestseller;

  factory StorageModel.fromJson(Map<String, dynamic> json) => StorageModel(
        id: json["id"],
        title: json["title"],
        asin: json["asin"],
        link: json["link"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        image: json["image"],
        isPrime: json["is_prime"],
        rating: json["rating"]?.toDouble(),
        ratingsTotal: json["ratings_total"],
        price: Price.fromJson(json["price"]),
        amazonsChoice: json["amazons_choice"] == null
            ? null
            : AmazonsChoice.fromJson(json["amazons_choice"]),
        availability: json["availability"] == null
            ? null
            : Availability.fromJson(json["availability"]),
        bestseller: json["bestseller"] == null
            ? null
            : Bestseller.fromJson(json["bestseller"]),
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
        "price": price.toJson(),
        "amazons_choice": amazonsChoice?.toJson(),
        "availability": availability?.toJson(),
        "bestseller": bestseller?.toJson(),
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

class Bestseller {
  Bestseller({
    required this.link,
    required this.category,
  });

  String link;
  String category;

  factory Bestseller.fromJson(Map<String, dynamic> json) => Bestseller(
        link: json["link"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "category": category,
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
        name: nameValues.map[json["name"]] ?? Name.DATA_STORAGE,
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "id": id,
      };
}

enum Name { DATA_STORAGE }

final nameValues = EnumValues({"Data Storage": Name.DATA_STORAGE});

class Price {
  Price({
    this.symbol,
    this.value,
    this.currency,
    required this.raw,
    this.name,
    this.isPrimary,
    this.asin,
    this.link,
  });

  Symbol? symbol;
  double? value;
  Currency? currency;
  String raw;
  String? name;
  bool? isPrimary;
  String? asin;
  String? link;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        symbol: symbolValues.map[json["symbol"]],
        value: json["value"]?.toDouble(),
        currency: currencyValues.map[json["currency"]],
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
