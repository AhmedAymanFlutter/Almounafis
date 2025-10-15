// cubit/global_settings_cubit.dart
import 'package:almonafs_flutter/features/global_Settings/data/repo/global_Setting_repo.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_stete.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/global_Setting_model.dart';


  
class GlobalSettingsCubit extends Cubit<GlobalSettingsState> {
  final GlobalSettingsRepository repository;

  GlobalSettingsCubit({required this.repository}) : super(GlobalSettingsInitial());

  // Get global settings
  Future<void> getGlobalSettings() async {
    emit(GlobalSettingsLoading());
    
    final response = await repository.getGlobalSettings();
    
    if (response.status) {
      if (response.data is GlobalSettingModel) {
        emit(GlobalSettingsLoaded(globalSettings: response.data));
      } else {
        emit(GlobalSettingsError(message: 'Invalid data format'));
      }
    } else {
      emit(GlobalSettingsError(message: response.message));
    }
  }

  // Clear error state
  void clearError() {
    if (state is GlobalSettingsError) {
      emit(GlobalSettingsInitial());
    }
  }
}