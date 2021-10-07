import 'package:quiz/data/models/question.dart';

class Game{

  Game();

  final List<Question> _questions = [
    Question("Prince Harry is taller than Prince William.", false),
    Question("The star sign Aquarius is represented by a tiger.", true),
    Question("Meryl Streep has won two Academy Awards.", false),
    Question("Marrakesh is the capital of Morocco.", false),
    Question("Idina Menzel sings 'let it go' 20 times in 'Let It Go' from Frozen ?", false),
    Question("Waterloo has the greatest number of tube platforms in London.", true),
    Question("M&M stands for Mars and Moordale.", false),
    Question("Gin is typically included in a Long Island Iced Tea.", true),
    Question("The unicorn is the national animal of Scotland", true),
    Question("There are two parts of the body that can't heal themselves", false),
  ];

  String getQuestion(int index){
    return _questions[index].question.toString();
  }

  bool questionValidation(int index, bool answer){
    return _questions[index].isTrue == answer;
  }

  int getNbQuestions(){
    return _questions.length;
  }

}