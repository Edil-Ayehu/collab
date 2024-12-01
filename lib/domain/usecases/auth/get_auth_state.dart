import 'package:injectable/injectable.dart';
import 'package:collab/data/models/user_model.dart';
import 'package:collab/domain/repositories/auth_repository.dart';

@lazySingleton
class GetAuthState {
  final AuthRepository _repository;

  GetAuthState(this._repository);

  Stream<UserModel?> call() {
    return _repository.authStateChanges;
  }
} 