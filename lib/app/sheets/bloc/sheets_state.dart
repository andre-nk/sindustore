part of 'sheets_bloc.dart';

abstract class SheetsState extends Equatable {
  const SheetsState();
  
  @override
  List<Object> get props => [];
}

class SheetsStateInitial extends SheetsState {}

class SheetsStateLoading extends SheetsState {}

class SheetsStateFailed extends SheetsState {
  final Exception exception;

  const SheetsStateFailed(this.exception);
}

class SheetsStateSuccess extends SheetsState{}


