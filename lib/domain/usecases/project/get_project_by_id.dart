import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/domain/entities/project.dart';
import 'package:collab/domain/repositories/project_repository.dart';

@lazySingleton
class GetProjectById {
  final ProjectRepository _repository;

  GetProjectById(this._repository);

  Future<Either<Failure, Project>> call(String id) async {
    return await _repository.getProjectById(id);
  }
} 