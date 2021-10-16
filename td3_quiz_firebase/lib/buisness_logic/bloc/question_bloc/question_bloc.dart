import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:td3_quiz_firebase/data/models/question_model.dart';
import 'package:td3_quiz_firebase/data/repositories/question_repository.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionRepository repository;

  QuestionBloc(this.repository) : super(QuestionInitial());
  QuestionState get initialState => QuestionInitial();

  @override
  Stream<QuestionState> mapEventToState(QuestionEvent event) async* {
    if (event is GetAllQuestions) {
      yield QuestionLoading();
      try {
        final List<Question?> questions = await repository.getQuestionsList();
        
        if(questions.isEmpty) {
          yield QuestionNotLoaded();
        } else {
          yield QuestionLoaded(questions);
        }
      } catch (error) {
        yield QuestionNotLoaded();
      }
    }else if(event is GetAllQuestionsForThematique){
      yield QuestionLoading();
      try {
        final List<Question?> questions = await repository.getQuestionsThematiqueList(event.thematique);
        
        if(questions.isEmpty) {
          yield QuestionNotLoaded();
        } else {
          yield QuestionLoaded(questions);
        }
      } catch (error) {
        yield QuestionNotLoaded();
      }
    }
  }
}
