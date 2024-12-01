import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, List<User>>> searchUsers(String query);
  Future<Either<Failure, User>> getUserById(String id);
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, void>> updateUser(User user);
} 