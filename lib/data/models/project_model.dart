import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collab/domain/entities/project.dart';

part 'project_model.freezed.dart';
part 'project_model.g.dart';

@freezed
class ProjectModel with _$ProjectModel {
  const ProjectModel._();

  const factory ProjectModel({
    required String id,
    required String title,
    required String description,
    @Default(0.0) double progress,
    required List<String> memberIds,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(false) bool isArchived,
    String? coverImageUrl,
    @Default([]) List<String> tags,
    @Default({}) Map<String, dynamic> metadata,
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  factory ProjectModel.fromEntity(Project project) => ProjectModel(
        id: project.id,
        title: project.title,
        description: project.description,
        progress: project.progress,
        memberIds: project.memberIds,
        createdAt: project.createdAt,
        updatedAt: project.updatedAt,
        isArchived: project.isArchived,
        coverImageUrl: project.coverImageUrl,
        tags: project.tags,
        metadata: project.metadata,
      );

  Project toEntity() => Project(
        id: id,
        title: title,
        description: description,
        progress: progress,
        memberIds: memberIds,
        createdAt: createdAt,
        updatedAt: updatedAt,
        isArchived: isArchived,
        coverImageUrl: coverImageUrl,
        tags: tags,
        metadata: metadata,
      );

  double get completionPercentage => progress * 100;

  bool get isCompleted => progress >= 1.0;

  bool get hasMembers => memberIds.isNotEmpty;

  bool get hasTags => tags.isNotEmpty;

  ProjectModel markAsUpdated() => copyWith(updatedAt: DateTime.now());

  ProjectModel addMember(String userId) =>
      copyWith(memberIds: [...memberIds, userId]);

  ProjectModel removeMember(String userId) =>
      copyWith(memberIds: memberIds.where((id) => id != userId).toList());

  ProjectModel addTag(String tag) => copyWith(tags: [...tags, tag]);

  ProjectModel removeTag(String tag) =>
      copyWith(tags: tags.where((t) => t != tag).toList());

  ProjectModel updateProgress(double newProgress) =>
      copyWith(progress: newProgress.clamp(0.0, 1.0));
}
