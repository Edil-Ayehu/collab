import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collab/domain/entities/user.dart';

part 'users_state.freezed.dart';

@freezed
class UsersState with _$UsersState {
  const UsersState._();

  const factory UsersState.initial() = _Initial;
  const factory UsersState.loading() = _Loading;
  const factory UsersState.loaded({
    required List<User> users,
    String? searchQuery,
  }) = _Loaded;
  const factory UsersState.error(String message) = _Error;
} 