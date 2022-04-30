part of 'discount_bloc.dart';

abstract class DiscountEvent extends Equatable {
  const DiscountEvent();

  @override
  List<Object> get props => [];
}

class DiscountEventFetch extends DiscountEvent {
  final String productID;

  const DiscountEventFetch({required this.productID});
}

class DiscountEventSelect extends DiscountEvent {
  final String discountID;

  const DiscountEventSelect({required this.discountID});
}

class DiscountEventDelete extends DiscountEvent {
  final String discountID;

  const DiscountEventDelete({required this.discountID});
}

class DiscountEventCreate extends DiscountEvent {
  final ProductDiscount discountModel;

  const DiscountEventCreate({required this.discountModel});
}

class DiscountEventUpdate extends DiscountEvent {
  final ProductDiscount discountModel;

  const DiscountEventUpdate({required this.discountModel});
}
