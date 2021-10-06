import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:quiz/data/models/game.dart';

// Import Modèle Question
import 'package:quiz/data/models/question.dart';


class MyQuizPage extends StatelessWidget {
  MyQuizPage({Key? key, required this.title}) : super(key: key);

  final String title;
  
  void _nextQuestion(BuildContext context){
    Provider.of<GameModel>(context, listen: false).nextQuestion();
  }

  void _checkAnswer(BuildContext context, bool answer){
    Provider.of<GameModel>(context, listen: false).checkAnswer(answer);
  }


  
  @override
  Widget build(BuildContext context){

    var _question = Provider.of<GameModel>(context).getQuestion();
    var _maxQuestion = Provider.of<GameModel>(context).getMaxQuestion();
    var _resultQuestion = Provider.of<GameModel>(context).getResult();
    var _isButtonDisabled = Provider.of<GameModel>(context).getButtonDisabled();
    var _score = Provider.of<GameModel>(context).getScore();
    var _index = Provider.of<GameModel>(context).getIndex();
    var _quizIsOver = Provider.of<GameModel>(context).quizIsOver();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Container( // Container for Header (score and index)
              width:350,
              height:50,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Question ${_index+1}/$_maxQuestion', 
                    style: const TextStyle(
                      fontSize: 18, 
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
                  Text('Score : $_score', 
                    style: const TextStyle(fontSize: 18))
                  ,],
                ) 
            ),
            const SizedBox(height: 10),
            Container( // Container for Image
              width:350,
              height:200,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Image(image: NetworkImage("https://images.assetsdelivery.com/compings_v2/soifer/soifer1809/soifer180900063.jpg"),)
            ),
            const SizedBox(height: 20),
            Container( // Container for Questions
              width:350,
              height:150,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2.0, 
                  color: _resultQuestion == 3 ? Colors.blueGrey.shade200 : (_resultQuestion == 1 ? Colors.green : Colors.red), )
              ),
              child: 
                Text(_question, 
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,)
            ),
            const SizedBox(height: 40),
            Container( // Container for Buttons
              width:350,
              height:50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                ElevatedButton(
                  onPressed: _isButtonDisabled ? null : () => _checkAnswer(context, true),
                  child: const Text("Vrai", style: TextStyle(fontSize: 18)),
                ),
                ElevatedButton(
                  onPressed: _isButtonDisabled ? null : () => _checkAnswer(context, false),
                  child: const Text("Faux", style: TextStyle(fontSize: 18))
                ),
                ElevatedButton(
                  onPressed: !_isButtonDisabled ? null : () => _nextQuestion(context),
                  child: Wrap(children:  [
                    Text(_quizIsOver ? "Recommencer" :"Suivant", style: const TextStyle(fontSize: 18)),
                    const Icon(Icons.keyboard_arrow_right)
                    ],
                  ),
                    
                ),
              
              ],),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),

    );
  }

}
