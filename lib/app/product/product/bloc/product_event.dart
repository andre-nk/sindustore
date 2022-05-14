part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductEventGenerateRandom extends ProductEvent {
  const ProductEventGenerateRandom();
}

class ProductEventFetchQuery extends ProductEvent {
  const ProductEventFetchQuery();
}

class ProductEventSearchActive extends ProductEvent {
  final String searchQuery;

  const ProductEventSearchActive({required this.searchQuery});
}

class ProductEventFilter extends ProductEvent {
  final String filterTag;

  const ProductEventFilter({required this.filterTag});
}

class ProductEventFetchByID extends ProductEvent {
  final String productID;

  const ProductEventFetchByID({required this.productID});
}

class ProductEventInvoiceFetch extends ProductEvent {
  final List<InvoiceItem> invoiceItems;

  const ProductEventInvoiceFetch({required this.invoiceItems});
}