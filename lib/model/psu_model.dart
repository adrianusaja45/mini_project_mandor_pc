// To parse this JSON data, do
//
//     final psuModel = psuModelFromJson(jsonString);

import 'dart:convert';

List<PsuModel> psuModelFromJson(String str) =>
    List<PsuModel>.from(json.decode(str).map((x) => PsuModel.fromJson(x)));

String psuModelToJson(List<PsuModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PsuModel {
  PsuModel({
    required this.id,
    required this.title,
    required this.link,
    required this.categories,
    required this.image,
    required this.rating,
    required this.ratingsTotal,
    required this.price,
    this.bestseller,
    this.isCarousel,
    this.carousel,
    this.availability,
  });

  int id;
  String title;

  String link;
  List<Category> categories;
  String image;
  AmazonsChoice? amazonsChoice;
  bool? isPrime;
  double? rating;
  int? ratingsTotal;
  Price price;
  Bestseller? bestseller;
  bool? isSmallBusiness;
  bool? isCarousel;
  Carousel? carousel;
  Availability? availability;
  Coupon? coupon;

  factory PsuModel.fromJson(Map<String, dynamic> json) => PsuModel(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        image: json["image"],
        rating: json["rating"]?.toDouble(),
        ratingsTotal: json["ratings_total"],
        price: Price.fromJson(json["price"]),
        bestseller: json["bestseller"] == null
            ? null
            : Bestseller.fromJson(json["bestseller"]),
        isCarousel: json["is_carousel"],
        carousel: json["carousel"] == null
            ? null
            : Carousel.fromJson(json["carousel"]),
        availability: json["availability"] == null
            ? null
            : Availability.fromJson(json["availability"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "image": image,
        "amazons_choice": amazonsChoice?.toJson(),
        "is_prime": isPrime,
        "rating": rating,
        "ratings_total": ratingsTotal,
        "price": price.toJson(),
        "bestseller": bestseller?.toJson(),
        "is_small_business": isSmallBusiness,
        "is_carousel": isCarousel,
        "carousel": carousel?.toJson(),
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

class Carousel {
  Carousel({
    required this.title,
    required this.subTitle,
    required this.id,
  });

  String title;
  String subTitle;
  String id;

  factory Carousel.fromJson(Map<String, dynamic> json) => Carousel(
        title: json["title"],
        subTitle: json["sub_title"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "sub_title": subTitle,
        "id": id,
      };
}

class Category {
  Category({
    required this.name,
    required this.id,
  });

  Name name;
  Id id;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: nameValues.map[json["name"]] ?? Name.ALL_DEPARTMENTS,
        id: idValues.map[json["id"]] ?? Id.APS,
      );

  Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "id": idValues.reverse[id],
      };
}

enum Id { APS }

final idValues = EnumValues({"aps": Id.APS});

enum Name { ALL_DEPARTMENTS }

final nameValues = EnumValues({"All Departments": Name.ALL_DEPARTMENTS});

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
        symbol: symbolValues.map[json["symbol"]] ?? Symbol.EMPTY,
        value: json["value"]?.toDouble(),
        currency: currencyValues.map[json["currency"]] ?? Currency.USD,
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
