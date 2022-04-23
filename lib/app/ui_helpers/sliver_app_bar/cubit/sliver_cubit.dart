import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'sliver_state.dart';

class SliverCubit extends Cubit<SliverState> {
  SliverCubit() : super(SliverShowAppBar());

  void verticalScroll(ScrollDirection direction){
    if(direction == ScrollDirection.reverse){
      emit(SliverHideAppBar());
    } else if (direction != ScrollDirection.reverse) {
      emit(SliverShowAppBar());
    }
  }

  void horizontalScroll(ScrollMetrics metrics){
    if (metrics.atEdge) {
      bool isTop = metrics.pixels == 0.0;
      if (isTop) {
        emit(SliverHorizontalReachStart());
      } else {
        emit(SliverHorizontalLeaveStart());
      }
    }
  }
}
