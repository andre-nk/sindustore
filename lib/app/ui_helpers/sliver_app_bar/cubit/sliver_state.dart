part of 'sliver_cubit.dart';

abstract class SliverState extends Equatable {
  const SliverState();

  @override
  List<Object> get props => [];
}

class SliverHideAppBar extends SliverState {}

class SliverShowAppBar extends SliverState {}

class SliverHorizontalReachStart extends SliverState {}

class SliverHorizontalLeaveStart extends SliverState {}
 