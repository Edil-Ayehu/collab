import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/domain/entities/project.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<Project>>> getProjects();
  Future<Either<Failure, Project>> getProjectById(String id);
  Future<Either<Failure, Project>> createProject(Project project);
  Future<Either<Failure, Project>> updateProject(Project project);
  Future<Either<Failure, void>> deleteProject(String id);
  Future<Either<Failure, void>> addMember(String projectId, String userId);
  Future<Either<Failure, void>> removeMember(String projectId, String userId);
} 