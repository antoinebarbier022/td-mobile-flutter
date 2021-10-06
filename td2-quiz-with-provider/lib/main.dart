import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:quiz/data/models/game.dart';

import 'package:quiz/presentation/pages/my_quizz_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Questions/Réponses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyQuizPage(title: 'Questions/Réponses'),
    );
    
  }
}