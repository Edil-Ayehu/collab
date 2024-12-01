import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:collab/core/errors/failures.dart';
import 'package:collab/domain/entities/project.dart';
import 'package:collab/domain/repositories/project_repository.dart';
import 'package:collab/data/models/project_model.dart';

@LazySingleton(as: ProjectRepository)
class ProjectRepositoryImpl implements ProjectRepository {
  final FirebaseFirestore _firestore;

  ProjectRepositoryImpl(this._firestore);

  @override
  Future<Either<Failure, List<Project>>> getProjects() async {
    try {
      final snapshot = await _firestore.collection('projects').get();
      final projects = snapshot.docs
          .map((doc) => ProjectModel.fromJson(doc.data()).toEntity())
          .toList();
      return right(projects);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Project>> getProjectById(String id) async {
    try {
      final doc = await _firestore.collection('projects').doc(id).get();
      if (!doc.exists) {
        return left(const ServerFailure('Project not found'));
      }
      return right(ProjectModel.fromJson(doc.data()!).toEntity());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Project>> createProject(Project project) async {
    try {
      final projectModel = ProjectModel.fromEntity(project);
      final docRef = _firestore.collection('projects').doc();
      final newProject = projectModel.copyWith(id: docRef.id);
      await docRef.set(newProject.toJson());
      return right(newProject.toEntity());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Project>> updateProject(Project project) async {
    try {
      final projectModel = ProjectModel.fromEntity(project);
      await _firestore
          .collection('projects')
          .doc(project.id)
          .update(projectModel.toJson());
      return right(project);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(String id) async {
    try {
      await _firestore.collection('projects').doc(id).delete();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addMember(
    String projectId,
    String userId,
  ) async {
    try {
      await _firestore.collection('projects').doc(projectId).update({
        'memberIds': FieldValue.arrayUnion([userId]),
      });
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeMember(
    String projectId,
    String userId,
  ) async {
    try {
      await _firestore.collection('projects').doc(projectId).update({
        'memberIds': FieldValue.arrayRemove([userId]),
      });
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
