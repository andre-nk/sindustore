import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sindu_store/model/user/user_model.dart';
import 'package:sindu_store/repository/auth/auth_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  StreamSubscription<User>? _userSubscription;

  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(Unauthenticated()) {
    on<AuthUserStateChanged>((event, emit) async {
      print(event.user);
      if(event.user.isNotEmpty){
        final localUser = await _authRepository.currentUser();
        emit(Authenticated(localUser));
      } else {
        emit(Unauthenticated());
      }
    });

    on<AuthLogoutRequested>((event, emit) {
      unawaited(_authRepository.signOut());
    });

    _userSubscription = _authRepository.user.listen((user) {
      add(AuthUserStateChanged(user));
    });
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
