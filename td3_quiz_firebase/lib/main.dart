import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:td3_quiz_firebase/buisness_logic/bloc/question_bloc/question_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/answer_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/next_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/score_quiz_cubit.dart';
import 'package:td3_quiz_firebase/data/repositories/question_repository.dart';
import 'package:td3_quiz_firebase/presentation/pages/home_page.dart';

import 'buisness_logic/bloc/thematique_bloc/theme_bloc.dart';
import 'data/repositories/theme_repository.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        BlocProvider<QuestionBloc>(
          create: (BuildContext context) => QuestionBloc(QuestionRepository()),
        ),
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => ThemeBloc(ThemeRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Questions/Réponses',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[200],
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(title: "Thématiques"),
        ),
    );
  }
}
