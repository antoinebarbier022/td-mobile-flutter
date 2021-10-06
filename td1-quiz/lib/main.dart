import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questions/Réponses',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyQuizPage(title: 'Questions/Réponses'),
    );
  }
}

class MyQuizPage extends StatefulWidget {
  const MyQuizPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyQuizPage> createState() => _MyQuizPageState();
}

class _MyQuizPageState extends State<MyQuizPage> {
  int _score = 0;
  int _index = 0; // emplacement de la question courante
  int _resp_correct = 0; // 3 états : aucune réponse = 0, vrai = 1, faux = 3
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

  void _nextQuestion() {
    setState(() {
      // on passe au niveau suivant seulement si on a répondu à la question
      if(_isButtonDisabled){
        _index+1 == _questions.length ? _reloadQuiz() : _index++;
        _resp_correct = 0;
        _isButtonDisabled = false;
      }
    });
  }

void _reloadQuiz() {
    setState(() {
      _index = 0;
      _score = 0;
      _resp_correct = 0;
      _isButtonDisabled = false;
    });
  }

  bool _quizIsOver(){
    return (_index+1 == _questions.length) && _isButtonDisabled;
      
  }

  void _checkAnswerTrue(){
    if(true == _questions[_index].isTrue){
      _isValid();
    }else{
     _isInvalid();
    }
  }

    void _checkAnswerFalse(){
    if(false == _questions[_index].isTrue){
      _isValid();
    }else{
     _isInvalid();
    }
  }

  void _isInvalid(){
    setState(() {
      _resp_correct = 2;
      _score -= 5;
      _isButtonDisabled = true;
    });
  }

  void _isValid(){
    setState(() {
      _resp_correct = 1;
      _score += 10;
      _isButtonDisabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                  Text('Question ${_index+1}/${_questions.length}', 
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
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image(image: NetworkImage("https://images.assetsdelivery.com/compings_v2/soifer/soifer1809/soifer180900063.jpg"),)
            ),
            const SizedBox(height: 20),
            Container( // Container for Questions
              width:350,
              height:150,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2.0, 
                  color: _resp_correct == 0 ? Colors.blueGrey.shade200 : (_resp_correct == 1 ? Colors.green : Colors.red), )
              ),
              child: 
                Text(_questions[_index].question.toString(), 
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
                  onPressed: _isButtonDisabled ? null : _checkAnswerTrue,
                  child: const Text("Vrai", style: TextStyle(fontSize: 18)),
                ),
                ElevatedButton(
                  onPressed: _isButtonDisabled ? null : _checkAnswerFalse,
                  child: const Text("Faux", style: TextStyle(fontSize: 18))
                ),
                ElevatedButton(
                  onPressed: !_isButtonDisabled ? null : _nextQuestion,
                  child: Wrap(children:  [
                    Text(_quizIsOver() ? "Recommencer" :"Suivant", style: const TextStyle(fontSize: 18)),
                    Icon(Icons.keyboard_arrow_right)
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

class Question{
  String? question;
  bool? isTrue;

  Question(this.question, this.isTrue);

  bool valid(bool resp){
    return resp == isTrue;
  }

}



