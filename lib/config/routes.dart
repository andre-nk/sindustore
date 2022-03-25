import 'package:flutter/material.dart';
import 'package:sindu_store/app/auth/bloc/auth_bloc.dart';
import 'package:sindu_store/presentation/screens/screens.dart';

List<Page> onGenerateAppViewPages(
  AuthState state,
  List<Page<dynamic>> pages,
) {
  print(state.toString() + "route");

  if(state is Authenticated){
    return [
      HomePage.page()
    ];
  } else if (state is Unauthenticated){
    return [
      OnboardingPage.page()
    ];
  } else {
    return [
      OnboardingPage.page()
    ];
  }
}