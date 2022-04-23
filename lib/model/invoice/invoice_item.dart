import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice_item.g.dart';

@JsonSerializable()
class InvoiceItem extends Equatable {
  final int quantity;
  final String productID;
  final double discount;

  const InvoiceItem({
    required this.quantity,
    required this.productID,
    required this.discount,
  });

  @override
  List<Object?> get props => [quantity, productID, discount];

  factory InvoiceItem.fromJson(Map<String, dynamic> json) => _$InvoiceItemFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceItemToJson(this);
}
