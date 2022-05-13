part of 'invoice_cubit.dart';

abstract class InvoiceValueState extends Equatable {
  const InvoiceValueState({required this.invoiceValue});
  final double invoiceValue;

  @override
  List<Object> get props => [];
}

class InvoiceValueStateInitial extends InvoiceValueState {
  const InvoiceValueStateInitial() : super(invoiceValue: 0.0);
}

class InvoiceValueStateLoaded extends InvoiceValueState {
  const InvoiceValueStateLoaded({required double invoiceValue})
      : super(invoiceValue: invoiceValue);
}

class InvoiceValueStateFailed extends InvoiceValueState {
  final Exception exception;

  const InvoiceValueStateFailed({required double invoiceValue, required this.exception})
      : super(invoiceValue: invoiceValue);
}
