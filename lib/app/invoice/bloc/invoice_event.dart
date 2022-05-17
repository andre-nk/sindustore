part of 'invoice_bloc.dart';

abstract class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object> get props => [];
}

class InvoiceEventActivate extends InvoiceEvent {
  const InvoiceEventActivate();
}

class InvoiceEventRead extends InvoiceEvent {
  final Invoice invoice;

  const InvoiceEventRead({required this.invoice});
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
  final double productDiscount;

  const InvoiceEventEditDiscount(
      {required this.invoice, required this.productID, required this.productDiscount});
}

class InvoiceEventMarkStatus extends InvoiceEvent {
  final Invoice invoice;
  final InvoiceStatus status;

  const InvoiceEventMarkStatus({required this.invoice, required this.status});
}

class InvoiceEventDeactivate extends InvoiceEvent {}

class InvoiceEventCreate extends InvoiceEvent {
  final Invoice invoice;

  const InvoiceEventCreate({required this.invoice});
}

class InvoiceEventUpdate extends InvoiceEvent {
  final Invoice invoice;
  final String invoiceUID;

  const InvoiceEventUpdate({required this.invoice, required this.invoiceUID});
}

class InvoiceEventDelete extends InvoiceEvent {
  final String invoiceUID;

  const InvoiceEventDelete({required this.invoiceUID});
}

class InvoiceEventUpdateCustomerName extends InvoiceEvent {
  final Invoice invoice;
  final String newCustomerName;

  const InvoiceEventUpdateCustomerName({required this.invoice, required this.newCustomerName});
}


class InvoiceEventFetchActiveQuery extends InvoiceEvent {}

class InvoiceEventFetchQueryByDate extends InvoiceEvent {
  final DateTime dateTime;

  const InvoiceEventFetchQueryByDate(this.dateTime);
}