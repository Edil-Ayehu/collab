import 'package:injectable/injectable.dart';
import 'package:collab/domain/repositories/auth_repository.dart';

@lazySingleton
class SignOut {
  final AuthRepository _repository;

  SignOut(this._repository);

  Future<void> call() async {
    return await _repository.signOut();
  }
} 