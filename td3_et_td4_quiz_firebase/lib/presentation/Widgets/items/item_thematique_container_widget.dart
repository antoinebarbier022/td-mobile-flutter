import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:td3_quiz_firebase/buisness_logic/bloc/thematique_bloc/thematique_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/answer_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/next_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/score_quiz_cubit.dart';
import 'package:td3_quiz_firebase/data/models/theme_model.dart';
import 'package:td3_quiz_firebase/presentation/pages/quiz_page.dart';
import 'package:td3_quiz_firebase/presentation/pages/update_questions_page.dart';

class ThematiqueItemContainer extends StatelessWidget {
  const ThematiqueItemContainer({
    Key? key,
    required this.state,
    required this.index,
  }) : super(key: key);

  final ThemeLoaded state;
  final int index;

  @override
  Widget build(BuildContext context) {
    void resetCubit(BuildContext c) {
      c.read<NextQuestionCubit>().reset();
      c.read<ScoreQuizCubit>().reset();
      c.read<AnswerQuestionCubit>().reset();
    }

    return InkWell(
      // bouton sur le container
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizPage(
                    thematique: state.getThemes.elementAt(index) as ThemeQuiz,
                  )),
        ).then((value) {
          resetCubit(context); // On reset les cubit lorsque l'on va sur un quiz
        });
      },
      child: Container(
          width: 200,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10), bottom: Radius.circular(0)),
                    image: DecorationImage(
                        image: NetworkImage(
                            (state.getThemes.elementAt(index)!.getUrl())),
                        fit: BoxFit.cover)),
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(state.getThemes.elementAt(index)!.nom,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.settings,
                      ),
                      color: Theme.of(context).hintColor,
                      onPressed: () => 
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateQuestionsPage(
                                        thematique:
                                            state.getThemes.elementAt(index)!.nom,
                                      )),
                            )
                          )
                ],
              ))
            ],
          )),
    );
  }
}
