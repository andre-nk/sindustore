import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:sindu_store/model/product/product.dart';
import 'package:sindu_store/repository/product/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(ProductRepository productRepository) : super(const ProductStateInitial()) {
    on<ProductEventGenerateRandom>((event, emit) async {
      try {
        emit(const ProductStateFetching());
        await productRepository.generateRandomProducts();
        emit(const ProductStateCreated());
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
  }
}
