import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sindu_store/model/invoice/invoice.dart';
import 'package:sindu_store/repository/invoice/invoice_repository.dart';

part 'invoice_state.dart';

class InvoiceValueCubit extends Cubit<InvoiceValueState> {
  final InvoiceRepository invoiceRepository;
  InvoiceValueCubit({required this.invoiceRepository}) : super(const InvoiceValueStateInitial());

  void sumInvoice(Invoice invoice) async {
    try {
      final double invoiceValue = await invoiceRepository.sumInvoice(invoice);
      emit(InvoiceValueStateLoaded(invoiceValue: invoiceValue));
    } on Exception catch (e) {
      emit(InvoiceValueStateFailed(invoiceValue: 0.0, exception: e));
    }
  }
}
