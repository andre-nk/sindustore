import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_discount.g.dart';

@JsonSerializable()
class ProductDiscount extends Equatable {
  final double amount;
  final String discountName;

  const ProductDiscount({required this.amount, required this.discountName});

  @override
  List<Object?> get props => [amount, discountName];

  factory ProductDiscount.fromJson(Map<String, dynamic> json) => _$ProductDiscountFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDiscountToJson(this);
}
