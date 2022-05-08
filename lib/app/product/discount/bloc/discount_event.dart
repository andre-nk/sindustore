part of 'discount_bloc.dart';

abstract class DiscountEvent extends Equatable {
  const DiscountEvent();

  @override
  List<Object> get props => [];
}


class DiscountEventCreate extends DiscountEvent {
  final double amount;
  final String productID;
  final String discountName;

  const DiscountEventCreate({required this.amount, required this.productID, required this.discountName});
} 

class DiscountEventFormChange extends DiscountEvent {
  final String discountName;
  final double amount;
  
  const DiscountEventFormChange({required this.discountName, required this.amount});
}