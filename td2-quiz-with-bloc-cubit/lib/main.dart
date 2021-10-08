import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/buisness_logic/cubits/answer_question_cubit.dart';

import 'package:quiz/buisness_logic/cubits/next_question_cubit.dart';
import 'package:quiz/buisness_logic/cubits/score_quiz_cubit.dart';
import 'package:quiz/ui/pages/my_quizz_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NextQuestionCubit>(
          create: (BuildContext context) => NextQuestionCubit(),
        ),
        BlocProvider<ScoreQuizCubit>(
          create: (BuildContext context) => ScoreQuizCubit(),
        ),
        BlocProvider<AnswerQuestionCubit>(
          create: (BuildContext context) => AnswerQuestionCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Questions/Réponses',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyQuizPage(title: 'Questions/Réponses'),
      ),
    );
  }
}
