import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sindu_store/repository/product/tags_repository.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  TagsBloc(TagsRepository tagsRepository) : super(TagsInitial()) {
    on<TagsEventFetch>((event, emit) async {
      try {
        emit(TagsStateFetching());
        final List<String> tags = await tagsRepository.fetchProductTags();

        emit(TagsStateLoaded(productTags: tags));
      } on Exception catch (e) {
        emit(TagsStateFetching(exception: e));
      }
    });

    on<TagsEventSelect>(((event, emit) {
      emit(TagsStateSelected(
        productTags: event.tags,
        activeTagIndex: event.activeTagIndex,
      ));
    }));
  }
}
