import 'package:flutter/material.dart';
import 'package:sindu_store/app/auth/bloc/app_bloc.dart';
import 'package:sindu_store/presentation/screens/screens.dart';

List<Page> onGenerateAppViewPages(
  AppState state,
  List<Page<dynamic>> pages,
) {
  if(state is Authenticated){
    return [
      PINInputPage.page()
    ];
  } else if (state is Unauthenticated){
    return [
      OnboardingPage.page()
    ];
  } else if (state is InitialAppState) {
    return [
      OnboardingPage.page()
    ];
  } else {
    return [
      OnboardingPage.page()
    ];
  }
}