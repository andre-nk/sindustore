part of 'sheets_bloc.dart';

abstract class SheetsEvent extends Equatable {
  const SheetsEvent();

  @override
  List<Object> get props => [];
}

class SheetsEventFetchRecord extends SheetsEvent {
  final DateTime dateTime;

  const SheetsEventFetchRecord(this.dateTime);
}
