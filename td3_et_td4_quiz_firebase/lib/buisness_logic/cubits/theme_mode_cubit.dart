import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode>{
  ThemeCubit() : super(ThemeMode.system);

  void dark() => emit(ThemeMode.dark);
  void light() => emit(ThemeMode.light);
  void switchTheme() => emit( (state == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light);
  void reset() => emit(ThemeMode.system);

}