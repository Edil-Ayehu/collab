import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:collab/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    String? name,
    String? phone,
    String? photoUrl,
    @Default({}) Map<String, dynamic> metadata,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntity(User user) => UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
        phone: user.phone,
        photoUrl: user.photoUrl,
        metadata: user.metadata,
      );

  factory UserModel.fromFirebaseUser(auth.User user) => UserModel(
        id: user.uid,
        email: user.email!,
        name: user.displayName,
        phone: user.phoneNumber,
        photoUrl: user.photoURL,
        metadata: {
          'emailVerified': user.emailVerified,
          'phoneNumber': user.phoneNumber,
          'createdAt': user.metadata.creationTime?.millisecondsSinceEpoch,
          'lastSignInTime': user.metadata.lastSignInTime?.millisecondsSinceEpoch,
        },
      );

  User toEntity() => User(
        id: id,
        email: email,
        name: name,
        phone: phone,
        photoUrl: photoUrl,
        metadata: metadata,
      );
}
