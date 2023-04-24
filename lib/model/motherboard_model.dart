// To parse this JSON data, do
//
//     final motherboardModel = motherboardModelFromJson(jsonString);

import 'dart:convert';

List<MotherboardModel> motherboardModelFromJson(String str) =>
    List<MotherboardModel>.from(
        json.decode(str).map((x) => MotherboardModel.fromJson(x)));

String motherboardModelToJson(List<MotherboardModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MotherboardModel {
  MotherboardModel({
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
    this.amazonsChoice,
    this.bestseller,
    this.availability,
  });

  int id;
  String title;
  String asin;
  String link;
  List<CategoryElement> categories;
  String image;
  bool? isPrime;
  double? rating;
  int? ratingsTotal;
  Price? price;
  AmazonsChoice? amazonsChoice;
  Bestseller? bestseller;
  Availability? availability;

  factory MotherboardModel.fromJson(Map<String, dynamic> json) =>
      MotherboardModel(
        id: json["id"],
        title: json["title"],
        asin: json["asin"],
        link: json["link"],
        categories: List<CategoryElement>.from(
            json["categories"].map((x) => CategoryElement.fromJson(x))),
        image: json["image"],
        isPrime: json["is_prime"],
        rating: json["rating"]?.toDouble(),
        ratingsTotal: json["ratings_total"],
        price: Price.fromJson(json["price"]),
        amazonsChoice: json["amazons_choice"] == null
            ? null
            : AmazonsChoice.fromJson(json["amazons_choice"]),
        bestseller: json["bestseller"] == null
            ? null
            : Bestseller.fromJson(json["bestseller"]),
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
        "price": price?.toJson(),
        "amazons_choice": amazonsChoice?.toJson(),
        "bestseller": bestseller?.toJson(),
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

class Bestseller {
  Bestseller({
    required this.link,
    required this.category,
  });

  String link;
  CategoryEnum category;

  factory Bestseller.fromJson(Map<String, dynamic> json) => Bestseller(
        link: json["link"],
        category: categoryEnumValues.map[json["category"]] ??
            CategoryEnum.COMPUTER_MOTHERBOARDS,
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "category": categoryEnumValues.reverse[category],
      };
}

enum CategoryEnum { COMPUTER_MOTHERBOARDS }

final categoryEnumValues =
    EnumValues({"Computer Motherboards": CategoryEnum.COMPUTER_MOTHERBOARDS});

class CategoryElement {
  CategoryElement({
    required this.name,
    required this.id,
  });

  CategoryEnum name;
  String id;

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        name: categoryEnumValues.map[json["name"]] ??
            CategoryEnum.COMPUTER_MOTHERBOARDS,
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": categoryEnumValues.reverse[name],
        "id": id,
      };
}

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
  Name? name;
  bool? isPrimary;
  String? asin;
  String? link;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        symbol: symbolValues.map[json["symbol"]] ?? Symbol.EMPTY,
        value: json["value"]?.toDouble(),
        currency: currencyValues.map[json["currency"]] ?? Currency.USD,
        raw: json["raw"],
        name: nameValues.map[json["name"]],
        isPrimary: json["is_primary"],
        asin: json["asin"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbolValues.reverse[symbol],
        "value": value,
        "currency": currencyValues.reverse[currency],
        "raw": raw,
        "name": nameValues.reverse[name],
        "is_primary": isPrimary,
        "asin": asin,
        "link": link,
      };
}

enum Currency { USD }

final currencyValues = EnumValues({"USD": Currency.USD});

enum Name { PRIMARY, SAVE_11, SAVE_10, SAVE_13 }

final nameValues = EnumValues({
  "Primary": Name.PRIMARY,
  "Save 10%": Name.SAVE_10,
  "Save 11%": Name.SAVE_11,
  "Save 13%": Name.SAVE_13
});

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
