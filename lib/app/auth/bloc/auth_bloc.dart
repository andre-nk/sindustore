import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sindu_store/model/user/user_model.dart';
import 'package:sindu_store/repository/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<User>? _userSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(authRepository.currentUser.isNotEmpty
            ? Authenticated(authRepository.currentUser)
            : Unauthenticated()) {

    on<AuthUserStateChanged>((event, emit) {
      emit(event.user.isNotEmpty ? Authenticated(event.user) : Unauthenticated());
    });
    
    on<AuthLogoutRequested>((event, emit) {
      unawaited(_authRepository.signOut());
    });

    _userSubscription = _authRepository.user.listen((user) {
      add(AuthUserStateChanged(user));
    });
  }

  @override
  Future<void> close(){
    _userSubscription?.cancel();  
    return super.close();
  }
}
