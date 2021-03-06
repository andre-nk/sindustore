part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  final Exception? exception;
  const ProductState({this.exception});

  @override
  List<Object> get props => [];
}

class ProductStateInitial extends ProductState {
  const ProductStateInitial() : super(exception: null);
}

class ProductStateFetching extends ProductState {
  const ProductStateFetching({Exception? exception}) : super(exception: exception);
}

class ProductStateQueryLoaded extends ProductState {
  final Query query;
  const ProductStateQueryLoaded({Exception? exception, required this.query})
      : super(exception: exception);
}

class ProductStateSuccess extends ProductState {
  const ProductStateSuccess({Exception? exception}) : super(exception: exception);
}

class ProductStateByIDLoaded extends ProductState {
  final Product product;

  const ProductStateByIDLoaded({required this.product});
}

class ProductStateInvoiceLoaded extends ProductState {
  final List<Product> invoiceProduct;

  const ProductStateInvoiceLoaded({required this.invoiceProduct});
}