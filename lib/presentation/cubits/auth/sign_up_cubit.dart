import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:collab/domain/usecases/auth/sign_up_with_email_password.dart';
import 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final SignUpWithEmailPassword _signUpWithEmailPassword;

  SignUpCubit(this._signUpWithEmailPassword) : super(SignUpState.initial());

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    emit(state.copyWith(
      isSubmitting: true,
      failureOrSuccessOption: none(),
    ));

    final result = await _signUpWithEmailPassword(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );

    emit(state.copyWith(
      isSubmitting: false,
      failureOrSuccessOption: some(result),
    ));
  }
} 