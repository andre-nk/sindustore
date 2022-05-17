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

class InvoiceStateCreated extends InvoiceState {}

class InvoiceStateQueryLoaded extends InvoiceState {
  final Query query;

  @override
  List<Object> get props => [query];

  const InvoiceStateQueryLoaded({Exception? exception, required this.query})
      : super(exception: exception);
}

class InvoiceStateQueryFetching extends InvoiceState {}

class InvoiceStateFailed extends InvoiceState {
  const InvoiceStateFailed({required Exception exception}) : super(exception: exception);
}
