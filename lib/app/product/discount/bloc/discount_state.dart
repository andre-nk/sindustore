part of 'discount_bloc.dart';

abstract class DiscountState extends Equatable {
  const DiscountState();
  
  @override
  List<Object> get props => [];
}

class DiscountStateFormChanged extends DiscountState {
  final String discountName;
  final double amount;

   @override
  List<Object> get props => [discountName, amount];

  const DiscountStateFormChanged({required this.discountName, required this.amount});
}

class DiscountStateLoading extends DiscountState {}

class DiscountStateCreated extends DiscountState {}

class DiscountStateFailed extends DiscountState {
  final Exception exception;

  const DiscountStateFailed(this.exception);
}