part of 'invoice_bloc.dart';

abstract class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object> get props => [];
}

class InvoiceEventActivate extends InvoiceEvent {
  final Invoice invoice;
  final String initialProductID;

  const InvoiceEventActivate({required this.invoice, required this.initialProductID});
}

class InvoiceEventAddItem extends InvoiceEvent {
  final Invoice invoice;
  final String productID;

  const InvoiceEventAddItem({required this.invoice, required this.productID});
}

class InvoiceEventRemoveItem extends InvoiceEvent {
  final Invoice invoice;
  final String productID;

  const InvoiceEventRemoveItem({required this.invoice, required this.productID});
}

class InvoiceEventEditDiscount extends InvoiceEvent {
  final Invoice invoice;
  final String productID;
  final ProductDiscount productDiscount;

  const InvoiceEventEditDiscount({required this.invoice, required this.productID, required this.productDiscount});
}

class InvoiceEventMarkStatus extends InvoiceEvent {
  final Invoice invoice;
  final InvoiceStatus status;

  const InvoiceEventMarkStatus({required this.invoice, required this.status});
}

class InvoiceEventDeactivate extends InvoiceEvent {}


