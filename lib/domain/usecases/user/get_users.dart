import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/domain/entities/user.dart';
import 'package:collab/domain/repositories/user_repository.dart';

@injectable
class GetUsers {
  final UserRepository _repository;

  GetUsers(this._repository);

  Future<Either<Failure, List<User>>> call() async {
    return await _repository.getUsers();
  }
} 