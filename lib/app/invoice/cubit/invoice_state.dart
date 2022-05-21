part of 'invoice_cubit.dart';

abstract class InvoiceValueState extends Equatable {
  const InvoiceValueState();

  @override
  List<Object> get props => [];
}

class InvoiceValueStateInitial extends InvoiceValueState {}

class InvoiceValueStateLoaded extends InvoiceValueState {
  final double invoiceValue;

  @override
  List<Object> get props => [invoiceValue];

  const InvoiceValueStateLoaded({required this.invoiceValue});
}

class InvoiceValueStateFailed extends InvoiceValueState {
  final Exception exception;

  const InvoiceValueStateFailed({required this.exception});
}
