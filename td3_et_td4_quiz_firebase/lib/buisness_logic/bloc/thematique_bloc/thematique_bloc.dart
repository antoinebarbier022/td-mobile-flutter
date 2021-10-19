import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:td3_quiz_firebase/data/models/theme_model.dart';
import 'package:td3_quiz_firebase/data/repositories/theme_repository.dart';

part 'thematique_event.dart';
part 'thematique_state.dart';

class ThematiqueBloc extends Bloc<ThematiqueEvent, ThematiqueState> {
  ThemeRepository repository;

  ThematiqueBloc(this.repository) : super(ThemeInitial());
  ThematiqueState get initialState => ThemeInitial();

    @override
  Stream<ThematiqueState> mapEventToState(ThematiqueEvent event) async* {
    if (event is GetAllThemes) {
      yield ThemeLoading();
      try {
        final List<ThemeQuiz?> themes = await repository.getThemeList();
        
        if(themes.isEmpty) {
          yield ThemeNotLoaded();
        } else {
          yield ThemeLoaded(themes);
        }
      } catch (error) {
        yield ThemeNotLoaded();
      }
    }
    }
}
