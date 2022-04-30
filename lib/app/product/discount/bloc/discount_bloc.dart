import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sindu_store/model/product/product_discount.dart';
import 'package:sindu_store/repository/product/discount_repository.dart';

part 'discount_event.dart';
part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  DiscountBloc(DiscountRepository discountRepository)
      : super(const DiscountStateInitial()) {
    on<DiscountEventFetch>((event, emit) async {
      try {
        List<ProductDiscount> productDiscounts =
            await discountRepository.fetchProductDiscounts(event.productID);
        emit(DiscountStateLoaded(productDiscounts: productDiscounts));
      } on Exception catch (e) {
        throw Exception(e.toString());
      }
    });

    on<DiscountEventSelect>((event, emit) {
      emit(DiscountStateActive(discountID: event.discountID));
    });
  }
}
