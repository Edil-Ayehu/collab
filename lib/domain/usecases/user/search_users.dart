import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/domain/entities/user.dart';
import 'package:collab/domain/repositories/user_repository.dart';

@injectable
class SearchUsers {
  final UserRepository _repository;

  SearchUsers(this._repository);

  Future<Either<Failure, List<User>>> call(String query) async {
    return await _repository.searchUsers(query);
  }
} 