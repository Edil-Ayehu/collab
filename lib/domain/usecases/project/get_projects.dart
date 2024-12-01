import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/domain/entities/project.dart';
import 'package:collab/domain/repositories/project_repository.dart';

@lazySingleton
class GetProjects {
  final ProjectRepository _repository;

  GetProjects(this._repository);

  Future<Either<Failure, List<Project>>> call() async {
    return await _repository.getProjects();
  }
} 