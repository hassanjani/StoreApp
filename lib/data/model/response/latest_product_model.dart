// To parse this JSON data, do
//
//     final latestProductModel = latestProductModelFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

LatestProductModel latestProductModelFromMap(String str) =>
    LatestProductModel.fromJson(json.decode(str));

String latestProductModelToMap(LatestProductModel data) =>
    json.encode(data.toMap());

class LatestProductModel {
  LatestProductModel({
    @required this.sellersIds,
    @required this.totalSize,
    @required this.limit,
    @required this.offset,
    @required this.products,
  });

  List<int> sellersIds;
  int totalSize;
  int limit;
  int offset;
  List<Product> products;

  factory LatestProductModel.fromJson(Map<String, dynamic> json) =>
      LatestProductModel(
        sellersIds: List<int>.from(json["sellersIds"].map((x) => x)),
        totalSize: json["total_size"],
        limit: json["limit"],
        offset: json["offset"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "sellersIds": List<dynamic>.from(sellersIds.map((x) => x)),
        "total_size": totalSize,
        "limit": limit,
        "offset": offset,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };
}

class Product {
  Product({
    @required this.id,
    @required this.addedBy,
    @required this.userId,
    @required this.name,
    @required this.slug,
    @required this.categoryIds,
    @required this.category,
    @required this.brandId,
    @required this.unit,
    @required this.minQty,
    @required this.refundable,
    @required this.images,
    @required this.thumbnail,
    @required this.featured,
    @required this.flashDeal,
    @required this.videoProvider,
    @required this.videoUrl,
    @required this.colors,
    @required this.variantProduct,
    @required this.attributes,
    @required this.choiceOptions,
    @required this.variation,
    @required this.published,
    @required this.unitPrice,
    @required this.purchasePrice,
    @required this.tax,
    @required this.taxType,
    @required this.discount,
    @required this.discountType,
    @required this.currentStock,
    @required this.details,
    @required this.freeShipping,
    @required this.attachment,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.status,
    @required this.featuredStatus,
    @required this.commission,
    @required this.shop,
  });

  int id;
  String addedBy;
  int userId;
  String name;
  String slug;
  List<CategoryId> categoryIds;
  int category;
  int brandId;
  String unit;
  int minQty;
  int refundable;
  List<String> images;
  String thumbnail;
  dynamic featured;
  dynamic flashDeal;
  dynamic videoProvider;
  dynamic videoUrl;
  List<dynamic> colors;
  int variantProduct;
  dynamic attributes;
  List<dynamic> choiceOptions;
  List<dynamic> variation;
  int published;
  int unitPrice;
  int purchasePrice;
  int tax;
  String taxType;
  int discount;
  String discountType;
  int currentStock;
  dynamic details;
  int freeShipping;
  dynamic attachment;
  DateTime createdAt;
  DateTime updatedAt;
  int status;
  int featuredStatus;
  int commission;
  Shop shop;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        addedBy: json["added_by"],
        userId: json["user_id"],
        name: json["name"],
        slug: json["slug"],
        categoryIds: List<CategoryId>.from(
            json["category_ids"].map((x) => CategoryId.fromMap(x))),
        category: json["category"],
        brandId: json["brand_id"],
        unit: json["unit"],
        minQty: json["min_qty"],
        refundable: json["refundable"],
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"],
        featured: json["featured"],
        flashDeal: json["flash_deal"],
        videoProvider: json["video_provider"],
        videoUrl: json["video_url"],
        colors: List<dynamic>.from(json["colors"].map((x) => x)),
        variantProduct: json["variant_product"],
        attributes: json["attributes"],
        choiceOptions: List<dynamic>.from(json["choice_options"].map((x) => x)),
        variation: List<dynamic>.from(json["variation"].map((x) => x)),
        published: json["published"],
        unitPrice: json["unit_price"],
        purchasePrice: json["purchase_price"],
        tax: json["tax"],
        taxType: json["tax_type"],
        discount: json["discount"],
        discountType: json["discount_type"],
        currentStock: json["current_stock"],
        details: json["details"],
        freeShipping: json["free_shipping"],
        attachment: json["attachment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        featuredStatus: json["featured_status"],
        commission: json["commission"],
        shop: Shop.fromMap(json["shop"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "added_by": addedBy,
        "user_id": userId,
        "name": name,
        "slug": slug,
        "category_ids": List<dynamic>.from(categoryIds.map((x) => x.toMap())),
        "category": category,
        "brand_id": brandId,
        "unit": unit,
        "min_qty": minQty,
        "refundable": refundable,
        "images": List<dynamic>.from(images.map((x) => x)),
        "thumbnail": thumbnail,
        "featured": featured,
        "flash_deal": flashDeal,
        "video_provider": videoProvider,
        "video_url": videoUrl,
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "variant_product": variantProduct,
        "attributes": attributes,
        "choice_options": List<dynamic>.from(choiceOptions.map((x) => x)),
        "variation": List<dynamic>.from(variation.map((x) => x)),
        "published": published,
        "unit_price": unitPrice,
        "purchase_price": purchasePrice,
        "tax": tax,
        "tax_type": taxType,
        "discount": discount,
        "discount_type": discountType,
        "current_stock": currentStock,
        "details": details,
        "free_shipping": freeShipping,
        "attachment": attachment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "featured_status": featuredStatus,
        "commission": commission,
        "shop": shop.toMap(),
      };
}

class CategoryId {
  CategoryId({
    @required this.id,
    @required this.position,
  });

  String id;
  int position;

  factory CategoryId.fromMap(Map<String, dynamic> json) => CategoryId(
        id: json["id"],
        position: json["position"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "position": position,
      };
}

class Shop {
  Shop({
    @required this.id,
    @required this.sellerId,
    @required this.category,
    @required this.name,
    @required this.address,
    @required this.contact,
    @required this.image,
    @required this.lt,
    @required this.lg,
    @required this.createdAt,
    @required this.updatedAt,
  });

  int id;
  int sellerId;
  int category;
  String name;
  String address;
  String contact;
  String image;
  String lt;
  String lg;
  DateTime createdAt;
  DateTime updatedAt;

  factory Shop.fromMap(Map<String, dynamic> json) => Shop(
        id: json["id"],
        sellerId: json["seller_id"],
        category: json["category"],
        name: json["name"],
        address: json["address"],
        contact: json["contact"],
        image: json["image"],
        lt: json["lt"],
        lg: json["lg"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "seller_id": sellerId,
        "category": category,
        "name": name,
        "address": address,
        "contact": contact,
        "image": image,
        "lt": lt,
        "lg": lg,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
