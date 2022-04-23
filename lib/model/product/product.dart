import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:sindu_store/model/product/product_discount.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  final String productName;
  final String productCoverURL;
  final double productBuyPrice;
  final double productSellPrice;
  final int productSoldCount;
  final int productStock;
  final List<String> tags;
  final List<ProductDiscount> productDiscounts;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Product({
    required this.productName,
    required this.productCoverURL,
    required this.productBuyPrice,
    required this.productSellPrice,
    required this.productSoldCount,
    required this.productStock,
    required this.productDiscounts,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    productName,
    productCoverURL,
    productBuyPrice,
    productSellPrice,
    productSoldCount,
    productStock,
    productDiscounts,
    tags,
    createdAt,
    updatedAt,
  ];

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
