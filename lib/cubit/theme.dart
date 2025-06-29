import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
   
   ThemeCubit(): super(ThemeMode.light) {
     // Try to hydrate, but don't fail if storage is not ready
     try {
       hydrate();
     } catch (e) {
       // If hydration fails, keep the default theme
       print('Hydration failed, using default theme: $e');
     }
   }

   void updateTheme(ThemeMode theme) => emit(theme);
    
  @override
   ThemeMode? fromJson(Map<String, dynamic> json) {
      try {
        return ThemeMode.values[json['theme'] as int];
      } catch (e) {
        return ThemeMode.light; // Fallback to light theme
      }
  }

  @override
  Map<String, dynamic>? toJson(state) {
      try {
        return {'theme': state.index};
      } catch (e) {
        return {'theme': ThemeMode.light.index}; // Fallback
      }
  }
} 