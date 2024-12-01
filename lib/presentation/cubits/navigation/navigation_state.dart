part of 'navigation_cubit.dart';

@freezed
class NavigationState with _$NavigationState {
  const factory NavigationState.home() = _Home;
  const factory NavigationState.tasks() = _Tasks;
  const factory NavigationState.projects() = _Projects;
  const factory NavigationState.settings() = _Settings;
} 