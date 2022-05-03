part of 'discount_bloc.dart';

abstract class DiscountState extends Equatable {
  const DiscountState({this.exception});
  final Exception? exception;

  @override
  List<Object> get props => [];
}

class DiscountStateInitial extends DiscountState {
  const DiscountStateInitial({Exception? exception}) : super(exception: exception);
}

class DiscountStateFetching extends DiscountState {
  const DiscountStateFetching({Exception? exception}) : super(exception: exception);
}

class DiscountStateLoaded extends DiscountState {
  final List<ProductDiscount> productDiscounts;
  
  const DiscountStateLoaded({required this.productDiscounts, Exception? exception}) : super(exception: exception);
}

class DiscountStateActive extends DiscountState {
  final ProductDiscount productDiscount;

  const DiscountStateActive({required this.productDiscount, Exception? exception})
      : super(exception: exception);
}
