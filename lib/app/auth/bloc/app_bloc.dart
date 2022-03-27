import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sindu_store/model/user/user_model.dart';
import 'package:sindu_store/repository/auth/auth_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AppState.initial()) {
          
    on<AuthUserStateChanged>((event, emit) async {
      print("Auth Bloc changed: " + event.user.toString());
      if (event.user.isNotEmpty) {
        final localUser = await _authRepository.currentUser();
        emit(AppState.authenticated(localUser));
      } else {
        emit(const AppState.unauthenticated());
      }
    });

    on<AuthLogoutRequested>((event, emit) {
      unawaited(_authRepository.signOut());
    });

    _userSubscription = _authRepository.user.listen((user) {
      print("Subs changed: " + user.toString());
      add(
        AuthUserStateChanged(user),
      );
    });
  }

  late final StreamSubscription<User> _userSubscription;

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
