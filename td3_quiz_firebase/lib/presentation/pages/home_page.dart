import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/bloc/thematique_bloc/theme_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/answer_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/next_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/score_quiz_cubit.dart';
import 'package:td3_quiz_firebase/data/models/theme_model.dart';
import 'package:td3_quiz_firebase/presentation/pages/formulaire_theme_page.dart';
import 'package:td3_quiz_firebase/presentation/pages/quiz_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    themeBloc.add(GetAllThemes());

    void resetCubit(BuildContext c) {
      c.read<NextQuestionCubit>().reset();
      c.read<ScoreQuizCubit>().reset();
      c.read<AnswerQuestionCubit>().reset();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FormulaireThemePage(title: 'Ajouter un Quiz',)),
                          );
                },
                child: const Icon(
                  Icons.add,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ThemeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ThemeLoaded) {
            return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: false,
                itemCount: state.getThemes.length,
                itemBuilder: (_, int index) {
                  return InkWell(
                    // bouton sur le container
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizPage(
                                  thematique: state.getThemes.elementAt(index)
                                      as ThemeQuiz,
                                )),
                      ).then((value) {
                        resetCubit(
                            context); // On reset les cubit lorsque l'on va sur un quiz
                      });
                    },
                    child: Container(
                        width: 200,
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10),
                                      bottom: Radius.circular(0)),
                                  image: DecorationImage(
                                      image: NetworkImage((state.getThemes
                                          .elementAt(index)!
                                          .getUrl())),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(state.getThemes.elementAt(index)!.nom),
                                  ],
                                ))
                          ],
                        )),
                  );
                });
            /*
                return Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        child: Text(state.getThemes.toString()),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QuizPage(
                                      thematique: 'Histoire',
                                    )),
                          );
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Maths'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QuizPage(
                                      thematique: 'Maths',
                                    )),
                          );
                        },
                      ),
                    ],
                  ),
                );
              */
          } else {
            return const Center(child: Text("Aucune Thématique."));
          }
        },
      ),
    );
  }
}
