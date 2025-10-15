// cubit/global_settings_state.dart

import '../data/model/global_Setting_model.dart';

abstract class GlobalSettingsState {
  const GlobalSettingsState();
}

class GlobalSettingsInitial extends GlobalSettingsState {}

class GlobalSettingsLoading extends GlobalSettingsState {}

class GlobalSettingsLoaded extends GlobalSettingsState {
  final GlobalSettingModel globalSettings;
  
  const GlobalSettingsLoaded({required this.globalSettings});
}

class GlobalSettingsError extends GlobalSettingsState {
  final String message;
  
  const GlobalSettingsError({required this.message});
}