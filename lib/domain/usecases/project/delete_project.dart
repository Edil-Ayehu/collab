import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/domain/repositories/project_repository.dart';

@lazySingleton
class DeleteProject {
  final ProjectRepository _repository;

  DeleteProject(this._repository);

  Future<Either<Failure, void>> call(String projectId) async {
    return await _repository.deleteProject(projectId);
  }
} 