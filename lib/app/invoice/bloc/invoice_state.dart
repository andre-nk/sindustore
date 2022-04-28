part of 'invoice_bloc.dart';

abstract class InvoiceState extends Equatable {
  final Exception? exception;
  const InvoiceState({this.exception});

  @override
  List<Object> get props => [];
}

class InvoiceStateInitial extends InvoiceState {
  const InvoiceStateInitial({Exception? exception}) : super(exception: exception);
}

class InvoiceStateActivated extends InvoiceState {
  final Invoice invoice;
  final String key;

  @override
  List<Object> get props => [key];

  const InvoiceStateActivated({
    required this.invoice,
    required this.key,
    Exception? exception,
  }) : super(exception: exception);
}
