import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final String? photoUrl;
  final Map<String, dynamic> metadata;

  const User({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.photoUrl,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [id, email, name, phone, photoUrl, metadata];
} 