// To parse this JSON data, do
//
//     final gpuModel = gpuModelFromJson(jsonString);

import 'dart:convert';

List<GpuModel> gpuModelFromJson(String str) =>
    List<GpuModel>.from(json.decode(str).map((x) => GpuModel.fromJson(x)));

String gpuModelToJson(List<GpuModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GpuModel {
  GpuModel({
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
    this.coupon,
    this.isCarousel,
    this.carousel,
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
  Coupon? coupon;
  bool? isCarousel;
  Carousel? carousel;

  factory GpuModel.fromJson(Map<String, dynamic> json) => GpuModel(
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
        price: Price?.fromJson(json["price"]),
        amazonsChoice: json["amazons_choice"] == null
            ? null
            : AmazonsChoice.fromJson(json["amazons_choice"]),
        availability: json["availability"] == null
            ? null
            : Availability.fromJson(json["availability"]),
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
        isCarousel: json["is_carousel"],
        carousel: json["carousel"] == null
            ? null
            : Carousel.fromJson(json["carousel"]),
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
        "coupon": coupon?.toJson(),
        "is_carousel": isCarousel,
        "carousel": carousel?.toJson(),
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

class Carousel {
  Carousel({
    required this.idCategory,
    required this.totalItems,
  });

  String idCategory;
  int totalItems;

  factory Carousel.fromJson(Map<String, dynamic> json) => Carousel(
        idCategory: json["idCategory"],
        totalItems: json["total_items"],
      );

  Map<String, dynamic> toJson() => {
        "idCategory": idCategory,
        "total_items": totalItems,
      };
}

class Category {
  Category({
    required this.name,
    required this.idCategory,
  });

  Name name;
  String idCategory;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: nameValues.map[json["name"]]!,
        idCategory: json["idCategory"],
      );

  Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "idCategory": idCategory,
      };
}

enum Name { COMPUTER_GRAPHICS_CARDS }

final nameValues =
    EnumValues({"Computer Graphics Cards": Name.COMPUTER_GRAPHICS_CARDS});

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
