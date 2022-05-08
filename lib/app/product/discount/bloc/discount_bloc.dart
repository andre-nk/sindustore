import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sindu_store/model/product/product_discount.dart';
import 'package:sindu_store/repository/product/discount_repository.dart';
import 'package:uuid/uuid.dart';

part 'discount_event.dart';
part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  DiscountBloc(DiscountRepository discountRepository)
      : super(const DiscountStateFormChanged(amount: 0.0, discountName: "")) {
    on<DiscountEventCreate>((event, emit) async {
      try {
        await discountRepository.createDiscount(
          event.productID,
          ProductDiscount(
            id: const Uuid().v4(),
            amount: -event.amount,
            discountName: event.discountName,
          ),
        );

        emit(DiscountStateCreated());
      } on Exception catch (e) {
        emit(DiscountStateFailed(e));
      }
    });

    on<DiscountEventFormChange>((event, emit) {
      emit(
        DiscountStateFormChanged(
          amount: event.amount,
          discountName: event.discountName,
        ),
      );
    });
  }
}
