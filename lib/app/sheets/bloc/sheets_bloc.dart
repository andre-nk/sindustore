import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sindu_store/model/invoice/invoice.dart';
import 'package:sindu_store/repository/sheets/sheets_repository.dart';

part 'sheets_event.dart';
part 'sheets_state.dart';

class SheetsBloc extends Bloc<SheetsEvent, SheetsState> {
  SheetsBloc(SheetsRepository sheetsRepository) : super(SheetsStateInitial()) {
    on<SheetsEventInsertInvoice>((event, emit) async {
      try {
        emit(SheetsStateLoading());
        await sheetsRepository.insertAndInitializeInvoice(event.invoice);
        emit(SheetsStateSuccess());
      } on Exception catch (e) {
        emit(SheetsStateFailed(e));
      }
    });
  }
}
