import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/data/models/user_model.dart';
import 'package:collab/domain/repositories/auth_repository.dart';

@lazySingleton
class SignInWithEmailPassword {
  final AuthRepository _repository;

  SignInWithEmailPassword(this._repository);

  Future<Either<Failure, UserModel>> call({
    required String email,
    required String password,
  }) async {
    return _repository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
} 