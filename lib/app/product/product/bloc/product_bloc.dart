import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:sindu_store/model/invoice/invoice_item.dart';
import 'package:sindu_store/model/product/product.dart';
import 'package:sindu_store/model/product/product_discount.dart';
import 'package:sindu_store/repository/product/product_repository.dart';
import 'package:uuid/uuid.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(ProductRepository productRepository) : super(const ProductStateInitial()) {
    on<ProductEventCreate>((event, emit) async {
      try {
        emit(const ProductStateFetching());
        await productRepository.createProduct(
          Product(
            id: const Uuid().v4(),
            productName: event.productName,
            productCoverURL: "",
            productBuyPrice: event.productBuyPrice,
            productSellPrice: event.productSellPrice,
            productSoldCount: 0,
            productStock: 0,
            productDiscounts: event.productDiscounts,
            tags: event.tags,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
        emit(const ProductStateSuccess());
      } on Exception catch (error) {
        emit(ProductStateFetching(exception: error));
      }
    });

    on<ProductEventUpdate>((event, emit) async {
      try {
        emit(const ProductStateFetching());
        await productRepository.updateProduct(
          Product(
            id: event.existingProductID,
            productName: event.productName,
            productCoverURL: "",
            productBuyPrice: event.productBuyPrice,
            productSellPrice: event.productSellPrice,
            productSoldCount: 0,
            productStock: 0,
            productDiscounts: event.productDiscounts,
            tags: event.tags,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
        emit(const ProductStateSuccess());
      } on Exception catch (error) {
        emit(ProductStateFetching(exception: error));
      }
    });

    on<ProductEventDelete>((event, emit) async {
      try {
        emit(const ProductStateFetching());
        await productRepository.deleteProduct(event.productID);
        emit(const ProductStateSuccess());
      } on Exception catch (error) {
        emit(ProductStateFetching(exception: error));
      }
    });

    on<ProductEventFetchQuery>((event, emit) async {
      try {
        emit(const ProductStateFetching());
        final Query<Product> query = await productRepository.fetchProductQuery();
        emit(ProductStateQueryLoaded(query: query));
      } on Exception catch (e) {
        throw ProductStateFetching(exception: e);
      }
    });

    on<ProductEventSearchActive>(((event, emit) async {
      try {
        emit(const ProductStateFetching());
        final Query<Product> query =
            await productRepository.searchProductQuery(event.searchQuery);
        emit(ProductStateQueryLoaded(query: query));
      } on Exception catch (e) {
        throw ProductStateFetching(exception: e);
      }
    }));

    on<ProductEventFilter>((event, emit) async {
      try {
        emit(const ProductStateFetching());
        final Query<Product> query =
            await productRepository.filterProductQuery(event.filterTag);
        emit(ProductStateQueryLoaded(query: query));
      } on Exception catch (e) {
        throw ProductStateFetching(exception: e);
      }
    });

    on<ProductEventFetchByID>((event, emit) async {
      try {
        emit(const ProductStateFetching());
        final Product productInstance =
            await productRepository.getProductByID(event.productID);

        emit(ProductStateByIDLoaded(product: productInstance));
      } on Exception catch (e) {
        emit(ProductStateFetching(exception: e));
      }
    });

    on<ProductEventInvoiceFetch>((event, emit) async {
      try {
        emit(const ProductStateFetching());
        final List<Product> invoiceProducts =
            await productRepository.fetchInvoiceItemsQuery(event.invoiceItems);

        emit(ProductStateInvoiceLoaded(invoiceProduct: invoiceProducts));
      } on Exception catch (e) {
        emit(ProductStateFetching(exception: e));
      }
    });
  }
}
