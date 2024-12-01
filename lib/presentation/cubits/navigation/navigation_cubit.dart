import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'navigation_state.dart';
part 'navigation_cubit.freezed.dart';

@injectable
class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState.home());

  void setPage(int index) {
    switch (index) {
      case 0:
        emit(const NavigationState.home());
        break;
      case 1:
        emit(const NavigationState.tasks());
        break;
      case 2:
        emit(const NavigationState.projects());
        break;
      case 3:
        emit(const NavigationState.settings());
        break;
    }
  }
} 