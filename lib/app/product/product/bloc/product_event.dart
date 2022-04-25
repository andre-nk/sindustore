part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductEventGenerateRandom extends ProductEvent {}

class ProductEventFetchQuery extends ProductEvent {}

class ProductEventSearchActive extends ProductEvent {
  final String searchQuery;

  const ProductEventSearchActive({required this.searchQuery});
}

class ProductEventFilter extends ProductEvent {
  final String filterTag;

  const ProductEventFilter({required this.filterTag});
}