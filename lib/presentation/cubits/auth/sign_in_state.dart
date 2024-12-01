import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/data/models/user_model.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    required bool isSubmitting,
    required Option<Either<Failure, UserModel>> failureOrSuccessOption,
  }) = _SignInState;

  factory SignInState.initial() => SignInState(
        isSubmitting: false,
        failureOrSuccessOption: none(),
      );
} 