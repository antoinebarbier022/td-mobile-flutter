part of 'thematique_bloc.dart';

@immutable
abstract class ThematiqueEvent {}


class GetAllThemes extends ThematiqueEvent {  
  GetAllThemes();
  List<Object> get props => [];
  @override
  String toString() => 'GetAllThemes';
}
