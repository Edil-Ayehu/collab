import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/domain/repositories/project_repository.dart';

@lazySingleton
class RemoveProjectMember {
  final ProjectRepository _repository;

  RemoveProjectMember(this._repository);

  Future<Either<Failure, void>> call({
    required String projectId,
    required String userId,
  }) async {
    return await _repository.removeMember(projectId, userId);
  }
} 