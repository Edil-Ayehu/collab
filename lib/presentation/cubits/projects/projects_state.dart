part of 'projects_cubit.dart';

enum ProjectFilter { all, active, archived }

enum ProjectSort { newest, oldest, title, progress }

@freezed
class ProjectsState with _$ProjectsState {
  const ProjectsState._();

  const factory ProjectsState.initial() = _Initial;
  const factory ProjectsState.loading() = _Loading;
  const factory ProjectsState.loaded({
    required List<Project> projects,
    @Default(ProjectFilter.all) ProjectFilter filter,
    @Default(ProjectSort.newest) ProjectSort sort,
    String? searchQuery,
  }) = _Loaded;
  const factory ProjectsState.error(String message) = _Error;

  List<Project>? get filteredProjects => maybeMap(
        loaded: (state) => state.projects,
        orElse: () => null,
      );
}
