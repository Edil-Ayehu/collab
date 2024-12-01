import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:collab/domain/entities/project.dart';
import 'package:collab/domain/usecases/project/get_projects.dart';
import 'package:collab/domain/usecases/project/create_project.dart';
import 'package:collab/domain/usecases/project/delete_project.dart';
import 'package:collab/domain/usecases/project/update_project.dart';
import 'package:collab/domain/usecases/project/archive_project.dart';
import 'package:collab/domain/usecases/project/add_project_member.dart';
import 'package:collab/domain/usecases/project/remove_project_member.dart';

part 'projects_state.dart';
part 'projects_cubit.freezed.dart';

@injectable
class ProjectsCubit extends Cubit<ProjectsState> {
  final GetProjects _getProjects;
  final CreateProject _createProject;
  final DeleteProject _deleteProject;
  final UpdateProject _updateProject;
  final ArchiveProject _archiveProject;
  final AddProjectMember _addProjectMember;
  final RemoveProjectMember _removeProjectMember;

  ProjectsCubit(
    this._getProjects,
    this._createProject,
    this._deleteProject,
    this._updateProject,
    this._archiveProject,
    this._addProjectMember,
    this._removeProjectMember,
  ) : super(const ProjectsState.initial());

  Future<void> loadProjects() async {
    emit(const ProjectsState.loading());
    final result = await _getProjects();
    result.fold(
      (failure) => emit(ProjectsState.error(failure.message)),
      (projects) => emit(ProjectsState.loaded(projects: projects)),
    );
  }

  Future<void> createProject({
    required String title,
    required String description,
    required List<String> memberIds,
  }) async {
    emit(const ProjectsState.loading());
    final result = await _createProject(
      title: title,
      description: description,
      memberIds: memberIds,
    );
    result.fold(
      (failure) => emit(ProjectsState.error(failure.message)),
      (_) => loadProjects(),
    );
  }

  Future<void> updateProject(Project project) async {
    emit(const ProjectsState.loading());
    final result = await _updateProject(project);
    result.fold(
      (failure) => emit(ProjectsState.error(failure.message)),
      (_) => loadProjects(),
    );
  }

  Future<void> archiveProject(String projectId) async {
    emit(const ProjectsState.loading());
    final result = await _archiveProject(projectId);
    result.fold(
      (failure) => emit(ProjectsState.error(failure.message)),
      (_) => loadProjects(),
    );
  }

  Future<void> deleteProject(String projectId) async {
    emit(const ProjectsState.loading());
    final result = await _deleteProject(projectId);
    result.fold(
      (failure) => emit(ProjectsState.error(failure.message)),
      (_) => loadProjects(),
    );
  }

  Future<void> addMember({
    required String projectId,
    required String userId,
  }) async {
    emit(const ProjectsState.loading());
    final result = await _addProjectMember(
      projectId: projectId,
      userId: userId,
    );
    result.fold(
      (failure) => emit(ProjectsState.error(failure.message)),
      (_) => loadProjects(),
    );
  }

  Future<void> removeMember({
    required String projectId,
    required String userId,
  }) async {
    emit(const ProjectsState.loading());
    final result = await _removeProjectMember(
      projectId: projectId,
      userId: userId,
    );
    result.fold(
      (failure) => emit(ProjectsState.error(failure.message)),
      (_) => loadProjects(),
    );
  }

  void setFilter(ProjectFilter filter) {
    state.mapOrNull(
      loaded: (state) => emit(ProjectsState.loaded(
        projects: state.projects,
        filter: filter,
        sort: state.sort,
        searchQuery: state.searchQuery,
      )),
    );
  }

  void setSort(ProjectSort sort) {
    state.mapOrNull(
      loaded: (state) => emit(ProjectsState.loaded(
        projects: state.projects,
        filter: state.filter,
        sort: sort,
        searchQuery: state.searchQuery,
      )),
    );
  }

  void setSearchQuery(String? query) {
    state.mapOrNull(
      loaded: (state) => emit(ProjectsState.loaded(
        projects: state.projects,
        filter: state.filter,
        sort: state.sort,
        searchQuery: query,
      )),
    );
  }

  List<Project> _getFilteredAndSortedProjects(
    List<Project> projects,
    ProjectFilter filter,
    ProjectSort sort,
    String? searchQuery,
  ) {
    var filtered = projects.where((project) {
      if (filter == ProjectFilter.active) return !project.isArchived;
      if (filter == ProjectFilter.archived) return project.isArchived;
      return true;
    }).toList();

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((project) {
        return project.title.toLowerCase().contains(query) ||
            project.description.toLowerCase().contains(query) ||
            project.tags.any((tag) => tag.toLowerCase().contains(query));
      }).toList();
    }

    switch (sort) {
      case ProjectSort.newest:
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case ProjectSort.oldest:
        filtered.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case ProjectSort.title:
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;
      case ProjectSort.progress:
        filtered.sort((a, b) => b.progress.compareTo(a.progress));
        break;
    }

    return filtered;
  }
} 