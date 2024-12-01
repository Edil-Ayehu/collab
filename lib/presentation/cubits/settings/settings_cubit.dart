import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(const SettingsState(
          isDarkMode: false,
          language: 'en',
          notificationsEnabled: true,
        ));

  void toggleTheme() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
    // TODO: Persist theme preference
  }

  void setLanguage(String languageCode) {
    emit(state.copyWith(language: languageCode));
    // TODO: Persist language preference
  }

  void toggleNotifications() {
    emit(state.copyWith(notificationsEnabled: !state.notificationsEnabled));
    // TODO: Persist notifications preference
  }
} 