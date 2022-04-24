import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
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
        emit(ProductStateFetching(
          exception: error
        ));
      }
    });

    on<ProductEventFetchQuery>((event, emit) async {
      try {
        emit(const ProductStateFetching());
        final CollectionReference query = await productRepository.fetchProductQuery();
        emit(ProductStateQueryLoaded(query: query));
      } on Exception catch (e) {
        throw ProductStateFetching(
          exception: e
        );
      } 
    }); 
  }
}
