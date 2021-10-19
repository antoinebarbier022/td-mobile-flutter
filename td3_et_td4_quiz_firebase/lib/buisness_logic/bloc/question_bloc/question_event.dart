part of 'question_bloc.dart';

@immutable
abstract class QuestionEvent {}


class GetAllQuestions extends QuestionEvent {  
  GetAllQuestions();
  List<Object> get props => [];
  @override
  String toString() => 'GetAllQuestions';
}

class GetAllQuestionsForThematique extends QuestionEvent { 

  final String thematique;

  GetAllQuestionsForThematique(this.thematique);
  List<Object> get props => [thematique];
  @override
  String toString() => 'GetAllQuestionsForThematique';
}

