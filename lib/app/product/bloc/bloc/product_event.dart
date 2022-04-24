part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductEventGenerateRandom extends ProductEvent {}

class ProductEventFetchQuery extends ProductEvent {}
