import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String id;
  final String title;
  final String description;
  final double progress;
  final List<String> memberIds;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isArchived;
  final String? coverImageUrl;
  final List<String> tags;
  final Map<String, dynamic> metadata;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    this.progress = 0.0,
    required this.memberIds,
    required this.createdAt,
    this.updatedAt,
    this.isArchived = false,
    this.coverImageUrl,
    this.tags = const [],
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        progress,
        memberIds,
        createdAt,
        updatedAt,
        isArchived,
        coverImageUrl,
        tags,
        metadata,
      ];
} 