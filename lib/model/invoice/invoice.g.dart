// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      adminHandlerUID: json['adminHandlerUID'] as String,
      customerName: json['customerName'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: $enumDecode(_$InvoiceStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'adminHandlerUID': instance.adminHandlerUID,
      'customerName': instance.customerName,
      'products': instance.products.map((e) => e.toJson()).toList(),
      'status': _$InvoiceStatusEnumMap[instance.status],
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$InvoiceStatusEnumMap = {
  InvoiceStatus.pending: 'pending',
  InvoiceStatus.loan: 'loan',
  InvoiceStatus.paid: 'paid',
  InvoiceStatus.cancelled: 'cancelled',
  InvoiceStatus.hold: 'hold',
  InvoiceStatus.returned: 'returned',
};
