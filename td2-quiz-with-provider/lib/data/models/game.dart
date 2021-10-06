import 'package:flutter/cupertino.dart';

import 'package:quiz/data/models/question.dart';

class GameModel extends ChangeNotifier{
  int score = 0;
  int _index = 0; // emplacement de la question courante

  int _resp_correct = 3; // 3 états : aucune réponse = 3, vrai = 1, faux = 0
  bool _isButtonDisabled = false;

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

  GameModel();

  String getQuestion(){
    return _questions[_index].question.toString();
  }

  String getMaxQuestion(){
    return _questions.length.toString();
  }

  int getResult(){
    return _resp_correct;
  }

  int getScore(){
    return score;
  }

  int getIndex(){
    return _index;
  }

  bool getButtonDisabled(){
    return _isButtonDisabled;
  }

  void nextQuestion() {
      // on passe au niveau suivant seulement si on a répondu à la question
      if(_isButtonDisabled){
        _index+1 == _questions.length ? reloadQuiz() : _index++;
        _resp_correct = 3;
        _isButtonDisabled = false;
        notifyListeners();
      }
  }

void reloadQuiz() {
      _index = 0;
      score = 0;
      _resp_correct = 3;
      _isButtonDisabled = false;
      notifyListeners();
  }

  bool quizIsOver(){
    return (_index+1 == _questions.length) && _isButtonDisabled;
  }



  void checkAnswer(bool answer){
    if(answer == _questions[_index].isTrue){
      _resp_correct = 1;
      score += 10;
      _isButtonDisabled = true;
    }else{
      _resp_correct = 0;
      score = (score > 0 ? score-5 : 0);
      _isButtonDisabled = true;
    }
    notifyListeners();
  }



  
}