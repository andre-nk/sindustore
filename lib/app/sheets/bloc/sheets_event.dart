part of 'sheets_bloc.dart';

abstract class SheetsEvent extends Equatable {
  const SheetsEvent();

  @override
  List<Object> get props => [];
}

class SheetsEventInsertInvoice extends SheetsEvent {
  final Invoice invoice;

  const SheetsEventInsertInvoice(this.invoice);
}
