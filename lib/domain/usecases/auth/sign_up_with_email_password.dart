import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/data/models/user_model.dart';
import 'package:collab/domain/repositories/auth_repository.dart';

@lazySingleton
class SignUpWithEmailPassword {
  final AuthRepository _repository;

  SignUpWithEmailPassword(this._repository);

  Future<Either<Failure, UserModel>> call({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    return _repository.signUpWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
  }
} 