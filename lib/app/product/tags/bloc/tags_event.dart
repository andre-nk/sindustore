part of 'tags_bloc.dart';

abstract class TagsEvent extends Equatable {
  const TagsEvent();

  @override
  List<Object> get props => [];
}

class TagsEventFetch extends TagsEvent {}

class TagsEventSelect extends TagsEvent {
  final int activeTagIndex;
  final List<String> tags;

  const TagsEventSelect({required this.tags, required this.activeTagIndex});
}
