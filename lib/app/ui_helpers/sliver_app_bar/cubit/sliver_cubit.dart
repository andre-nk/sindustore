import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';

class SliverCubit extends Cubit<bool> {
  SliverCubit() : super(false);

  void scroll(ScrollDirection direction){
    if(direction == ScrollDirection.forward || direction == ScrollDirection.idle){
      emit(true);
    } else {
      emit(false);
    }
  }
}
