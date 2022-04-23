part of 'invoice_bloc.dart';

abstract class InvoiceState extends Equatable {
  const InvoiceState();
  
  @override
  List<Object> get props => [];
}

class InvoiceInitial extends InvoiceState {}
