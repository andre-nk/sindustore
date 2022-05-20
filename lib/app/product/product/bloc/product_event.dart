part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductEventCreate extends ProductEvent {
  final String productName;
  final double productBuyPrice;
  final double productSellPrice;
  final List<String> tags;
  final List<ProductDiscount> productDiscounts;

  const ProductEventCreate({
    required this.productName,
    required this.productBuyPrice,
    required this.productSellPrice,
    required this.tags,
    required this.productDiscounts,
  });
}

class ProductEventUpdate extends ProductEvent {
  final String existingProductID;
  final String productName;
  final double productBuyPrice;
  final double productSellPrice;
  final List<String> tags;
  final List<ProductDiscount> productDiscounts;

  const ProductEventUpdate({
    required this.existingProductID,
    required this.productName,
    required this.productBuyPrice,
    required this.productSellPrice,
    required this.tags,
    required this.productDiscounts,
  });
}

class ProductEventDelete extends ProductEvent{
  final String productID;

  const ProductEventDelete(this.productID);

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
