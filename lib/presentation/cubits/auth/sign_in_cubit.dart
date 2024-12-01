import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:collab/domain/usecases/auth/sign_in_with_email_password.dart';
import 'sign_in_state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  final SignInWithEmailPassword _signInWithEmailPassword;

  SignInCubit(this._signInWithEmailPassword) : super(SignInState.initial());

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(
      isSubmitting: true,
      failureOrSuccessOption: none(),
    ));

    final result = await _signInWithEmailPassword(
      email: email,
      password: password,
    );

    emit(state.copyWith(
      isSubmitting: false,
      failureOrSuccessOption: some(result),
    ));
  }
}
