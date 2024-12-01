part of 'settings_cubit.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required bool isDarkMode,
    required String language,
    required bool notificationsEnabled,
  }) = _SettingsState;
} 