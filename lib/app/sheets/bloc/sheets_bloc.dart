import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sindu_store/repository/sheets/sheets_repository.dart';

part 'sheets_event.dart';
part 'sheets_state.dart';

class SheetsBloc extends Bloc<SheetsEvent, SheetsState> {
  SheetsBloc(SheetsRepository sheetsRepository) : super(SheetsStateInitial()) {
    on<SheetsEventFetchRecord>((event, emit) async {
      try {
        emit(SheetsStateLoading());
        final List<Map<String, dynamic>> recordItems = await sheetsRepository.fetchInvoiceRecord(event.dateTime);
        emit(SheetsStateSuccess(recordItems: recordItems));
      } on Exception catch (e) {
        emit(SheetsStateFailed(e));
      }
    });
  }
}
