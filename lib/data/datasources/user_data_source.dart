import 'package:collab/data/models/user_model.dart';

abstract class UserDataSource {
  Future<List<UserModel>> getUsers();
  Future<List<UserModel>> searchUsers(String query);
  Future<UserModel> getUserById(String id);
  Future<UserModel> getCurrentUser();
  Future<void> updateUser(UserModel user);
}