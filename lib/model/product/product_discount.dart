import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'product_discount.g.dart';

@JsonSerializable()
class ProductDiscount extends Equatable {
  final String id;
  final double amount;
  final String discountName;

  const ProductDiscount({required this.id, required this.amount, required this.discountName});

  @override
  List<Object?> get props => [id, amount, discountName];

  factory ProductDiscount.fromJson(Map<String, dynamic> json) => _$ProductDiscountFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDiscountToJson(this);
}
