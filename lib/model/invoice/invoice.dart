import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sindu_store/model/invoice/invoice_item.dart';
import 'package:sindu_store/model/invoice/invoice_status.dart';

part 'invoice.g.dart';

@JsonSerializable()
class Invoice extends Equatable {
  final String adminHandlerUID;
  final String customerName;
  final List<InvoiceItem> products;
  final InvoiceStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Invoice({
    required this.adminHandlerUID,
    required this.customerName,
    required this.products,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    adminHandlerUID,
    customerName,
    products,
    status,
    createdAt,
    updatedAt
  ];

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}
