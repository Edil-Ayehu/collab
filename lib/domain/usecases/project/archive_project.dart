import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/domain/entities/project.dart';
import 'package:collab/domain/repositories/project_repository.dart';

@lazySingleton
class ArchiveProject {
  final ProjectRepository _repository;

  ArchiveProject(this._repository);

  Future<Either<Failure, Project>> call(String projectId) async {
    final result = await _repository.getProjectById(projectId);
    return result.fold(
      (failure) => left(failure),
      (project) {
        final updatedProject = Project(
          id: project.id,
          title: project.title,
          description: project.description,
          progress: project.progress,
          memberIds: project.memberIds,
          createdAt: project.createdAt,
          updatedAt: DateTime.now(),
          isArchived: true,
          coverImageUrl: project.coverImageUrl,
          tags: project.tags,
          metadata: project.metadata,
        );
        return _repository.updateProject(updatedProject);
      },
    );
  }
} 