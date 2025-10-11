import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage { english, arabic }

class LanguageCubit extends Cubit<AppLanguage> {
  LanguageCubit() : super(AppLanguage.english) {
    _loadSavedLanguage();
  }

  // Load the saved language when app starts
  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('lang') ?? 'en';
    emit(saved == 'ar' ? AppLanguage.arabic : AppLanguage.english);
  }

  // Change and save language
  Future<void> setLanguage(AppLanguage lang) async {
    emit(lang);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', lang == AppLanguage.arabic ? 'ar' : 'en');
  }

  bool get isArabic => state == AppLanguage.arabic;
}
