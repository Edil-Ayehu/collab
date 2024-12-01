import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/domain/repositories/project_repository.dart';

@lazySingleton
class AddProjectMember {
  final ProjectRepository _repository;

  AddProjectMember(this._repository);

  Future<Either<Failure, void>> call({
    required String projectId,
    required String userId,
  }) async {
    return await _repository.addMember(projectId, userId);
  }
} 