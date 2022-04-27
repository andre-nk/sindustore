part of 'tags_bloc.dart';

abstract class TagsState extends Equatable {
  final Exception? exception;
  final List<String> productTags;
  const TagsState({this.exception, required this.productTags});

  @override
  List<Object> get props => [];
}

class TagsInitial extends TagsState {
  TagsInitial() : super(exception: null, productTags: []);
}

class TagsStateFetching extends TagsState {
  TagsStateFetching({Exception? exception})
      : super(exception: exception, productTags: []);
}

class TagsStateLoaded extends TagsState {
  const TagsStateLoaded({
    Exception? exception,
    required List<String> productTags,
  }) : super(exception: exception, productTags: productTags);
}

class TagsStateSelected extends TagsState {
  final int activeTagIndex;

  const TagsStateSelected({
    Exception? exception,
    required this.activeTagIndex,
    required List<String> productTags,
  }) : super(exception: exception, productTags: productTags);


  @override
  List<Object> get props => [activeTagIndex];
}
