part of 'thematique_bloc.dart';

@immutable
abstract class ThematiqueState {}

class ThematiqueInitial extends ThematiqueState {}



class ThemeInitial extends ThematiqueState {
  @override
  String toString() => 'ThemeInitial';
}


class ThemeLoading extends ThematiqueState {
  @override
  String toString() => 'ThemeLoading';
}

// ignore: must_be_immutable
class ThemeLoaded extends ThematiqueState {
  List<ThemeQuiz?> themes = [];

  ThemeLoaded(this.themes);

  List<ThemeQuiz?> get getThemes => themes;

  List<Object> get props => [themes];

  @override
  String toString() => 'ThemeLoaded';
}

class ThemeNotLoaded extends ThematiqueState {
  @override
  String toString() => 'ThemeNotLoaded';
}
