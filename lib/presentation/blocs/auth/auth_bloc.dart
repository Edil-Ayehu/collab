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

  AuthBloc(
    this._getAuthState,
    this._signOut,
  ) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
        started: (_) async {
          emit(const AuthState.loading());
          await _getAuthState().first.then(
            (userOption) => userOption != null
                ? emit(AuthState.authenticated(user: userOption))
                : emit(const AuthState.unauthenticated()),
          );
        },
        authStateChanged: (e) async {
          e.user != null
              ? emit(AuthState.authenticated(user: e.user!))
              : emit(const AuthState.unauthenticated());
        },
        signedOut: (_) async {
          await _signOut();
          emit(const AuthState.unauthenticated());
        },
      );
    });
  }
} 