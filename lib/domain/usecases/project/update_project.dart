import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/domain/entities/project.dart';
import 'package:collab/domain/repositories/project_repository.dart';

@lazySingleton
class UpdateProject {
  final ProjectRepository _repository;

  UpdateProject(this._repository);

  Future<Either<Failure, Project>> call(Project project) async {
    return await _repository.updateProject(project);
  }
} 