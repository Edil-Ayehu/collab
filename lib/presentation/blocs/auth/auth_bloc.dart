import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:collab/domain/usecases/auth/get_auth_state.dart';
import 'package:collab/domain/usecases/auth/sign_out.dart';
import 'package:collab/data/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthState _getAuthState;
  final SignOut _signOut;
  StreamSubscription<UserModel?>? _authStateSubscription;

  AuthBloc(
    this._getAuthState,
    this._signOut,
  ) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(
        started: () async {
          emit(const AuthState.loading());
          _authStateSubscription?.cancel();
          _authStateSubscription = _getAuthState().listen(
            (user) => add(AuthEvent.authStateChanged(user)),
          );
        },
        authStateChanged: (user) async {
          if (user != null) {
            emit(AuthState.authenticated(user: user));
          } else {
            emit(const AuthState.unauthenticated());
          }
        },
        signedOut: () async {
          emit(const AuthState.loading());
          await _signOut();
          emit(const AuthState.unauthenticated());
        },
      );
    });
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
} 