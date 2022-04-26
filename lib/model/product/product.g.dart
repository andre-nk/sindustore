// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      productName: json['productName'] as String,
      productCoverURL: json['productCoverURL'] as String,
      productBuyPrice: (json['productBuyPrice'] as num).toDouble(),
      productSellPrice: (json['productSellPrice'] as num).toDouble(),
      productSoldCount: json['productSoldCount'] as int,
      productStock: json['productStock'] as int,
      productDiscounts: (json['productDiscounts'] as List<dynamic>)
          .map((e) => ProductDiscount.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
      'productCoverURL': instance.productCoverURL,
      'productBuyPrice': instance.productBuyPrice,
      'productSellPrice': instance.productSellPrice,
      'productSoldCount': instance.productSoldCount,
      'productStock': instance.productStock,
      'tags': instance.tags,
      'productDiscounts': instance.productDiscounts.map((discount) => discount.toJson()).toList(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
