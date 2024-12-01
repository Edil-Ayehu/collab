// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasources/firebase_user_data_source.dart' as _i387;
import '../../data/datasources/user_data_source.dart' as _i853;
import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../data/repositories/project_repository_impl.dart' as _i281;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/repositories/project_repository.dart' as _i223;
import '../../domain/repositories/user_repository.dart' as _i271;
import '../../domain/usecases/auth/get_auth_state.dart' as _i769;
import '../../domain/usecases/auth/sign_in_with_email_password.dart' as _i1026;
import '../../domain/usecases/auth/sign_out.dart' as _i432;
import '../../domain/usecases/auth/sign_up_with_email_password.dart' as _i14;
import '../../domain/usecases/project/add_project_member.dart' as _i735;
import '../../domain/usecases/project/archive_project.dart' as _i981;
import '../../domain/usecases/project/create_project.dart' as _i1016;
import '../../domain/usecases/project/delete_project.dart' as _i731;
import '../../domain/usecases/project/get_project_by_id.dart' as _i599;
import '../../domain/usecases/project/get_projects.dart' as _i922;
import '../../domain/usecases/project/remove_project_member.dart' as _i879;
import '../../domain/usecases/project/update_project.dart' as _i586;
import '../../domain/usecases/user/get_users.dart' as _i336;
import '../../domain/usecases/user/search_users.dart' as _i170;
import '../../presentation/blocs/auth/auth_bloc.dart' as _i141;
import '../../presentation/cubits/auth/sign_in_cubit.dart' as _i844;
import '../../presentation/cubits/auth/sign_up_cubit.dart' as _i923;
import '../../presentation/cubits/navigation/navigation_cubit.dart' as _i77;
import '../../presentation/cubits/projects/projects_cubit.dart' as _i1051;
import '../../presentation/cubits/settings/settings_cubit.dart' as _i266;
import '../../presentation/cubits/tasks/tasks_cubit.dart' as _i859;
import '../../presentation/cubits/users/users_cubit.dart' as _i93;
import 'injectable_module.dart' as _i109;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final injectableModule = _$InjectableModule();
  gh.factory<_i77.NavigationCubit>(() => _i77.NavigationCubit());
  gh.factory<_i266.SettingsCubit>(() => _i266.SettingsCubit());
  gh.factory<_i859.TasksCubit>(() => _i859.TasksCubit());
  gh.lazySingleton<_i59.FirebaseAuth>(() => injectableModule.firebaseAuth);
  gh.lazySingleton<_i974.FirebaseFirestore>(() => injectableModule.firestore);
  gh.lazySingleton<_i457.FirebaseStorage>(() => injectableModule.storage);
  gh.factory<_i853.UserDataSource>(() => _i387.FirebaseUserDataSource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ));
  gh.factory<_i1073.AuthRepository>(() => _i895.AuthRepositoryImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
      ));
  gh.factory<_i336.GetUsers>(() => _i336.GetUsers(gh<_i271.UserRepository>()));
  gh.factory<_i170.SearchUsers>(
      () => _i170.SearchUsers(gh<_i271.UserRepository>()));
  gh.lazySingleton<_i223.ProjectRepository>(
      () => _i281.ProjectRepositoryImpl(gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i735.AddProjectMember>(
      () => _i735.AddProjectMember(gh<_i223.ProjectRepository>()));
  gh.lazySingleton<_i981.ArchiveProject>(
      () => _i981.ArchiveProject(gh<_i223.ProjectRepository>()));
  gh.lazySingleton<_i1016.CreateProject>(
      () => _i1016.CreateProject(gh<_i223.ProjectRepository>()));
  gh.lazySingleton<_i731.DeleteProject>(
      () => _i731.DeleteProject(gh<_i223.ProjectRepository>()));
  gh.lazySingleton<_i922.GetProjects>(
      () => _i922.GetProjects(gh<_i223.ProjectRepository>()));
  gh.lazySingleton<_i599.GetProjectById>(
      () => _i599.GetProjectById(gh<_i223.ProjectRepository>()));
  gh.lazySingleton<_i879.RemoveProjectMember>(
      () => _i879.RemoveProjectMember(gh<_i223.ProjectRepository>()));
  gh.lazySingleton<_i586.UpdateProject>(
      () => _i586.UpdateProject(gh<_i223.ProjectRepository>()));
  gh.lazySingleton<_i1026.SignInWithEmailPassword>(
      () => _i1026.SignInWithEmailPassword(gh<_i1073.AuthRepository>()));
  gh.lazySingleton<_i432.SignOut>(
      () => _i432.SignOut(gh<_i1073.AuthRepository>()));
  gh.lazySingleton<_i14.SignUpWithEmailPassword>(
      () => _i14.SignUpWithEmailPassword(gh<_i1073.AuthRepository>()));
  gh.lazySingleton<_i769.GetAuthState>(
      () => _i769.GetAuthState(gh<_i1073.AuthRepository>()));
  gh.factory<_i93.UsersCubit>(() => _i93.UsersCubit(
        gh<_i336.GetUsers>(),
        gh<_i170.SearchUsers>(),
      ));
  gh.factory<_i923.SignUpCubit>(
      () => _i923.SignUpCubit(gh<_i14.SignUpWithEmailPassword>()));
  gh.factory<_i844.SignInCubit>(
      () => _i844.SignInCubit(gh<_i1026.SignInWithEmailPassword>()));
  gh.factory<_i1051.ProjectsCubit>(() => _i1051.ProjectsCubit(
        gh<_i922.GetProjects>(),
        gh<_i1016.CreateProject>(),
        gh<_i731.DeleteProject>(),
        gh<_i586.UpdateProject>(),
        gh<_i981.ArchiveProject>(),
        gh<_i735.AddProjectMember>(),
        gh<_i879.RemoveProjectMember>(),
      ));
  gh.factory<_i141.AuthBloc>(() => _i141.AuthBloc(
        gh<_i769.GetAuthState>(),
        gh<_i432.SignOut>(),
      ));
  return getIt;
}

class _$InjectableModule extends _i109.InjectableModule {}
