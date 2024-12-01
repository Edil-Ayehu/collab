import 'package:collab/domain/usecases/user/get_users.dart';
import 'package:collab/domain/usecases/user/search_users.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'users_state.dart';

@injectable
class UsersCubit extends Cubit<UsersState> {
  final GetUsers _getUsers;
  final SearchUsers _searchUsers;

  UsersCubit(
    this._getUsers,
    this._searchUsers,
  ) : super(const UsersState.initial());

  Future<void> loadUsers() async {
    emit(const UsersState.loading());
    final result = await _getUsers();
    result.fold(
      (failure) => emit(UsersState.error(failure.message)),
      (users) => emit(UsersState.loaded(users: users)),
    );
  }

  Future<void> searchUsers(String query) async {
    if (query.isEmpty) {
      loadUsers();
      return;
    }

    emit(const UsersState.loading());
    final result = await _searchUsers(query);
    result.fold(
      (failure) => emit(UsersState.error(failure.message)),
      (users) => emit(UsersState.loaded(users: users, searchQuery: query)),
    );
  }
} 