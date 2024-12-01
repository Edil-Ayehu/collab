import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/domain/entities/project.dart';
import 'package:collab/domain/repositories/project_repository.dart';

@lazySingleton
class CreateProject {
  final ProjectRepository _repository;

  CreateProject(this._repository);

  Future<Either<Failure, Project>> call({
    required String title,
    required String description,
    required List<String> memberIds,
  }) async {
    final project = Project(
      id: '', // Will be set by repository
      title: title,
      description: description,
      memberIds: memberIds,
      createdAt: DateTime.now(),
    );
    return await _repository.createProject(project);
  }
} 