import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:td3_quiz_firebase/buisness_logic/bloc/question_bloc/question_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/bloc/thematique_bloc/thematique_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/answer_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/next_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/score_quiz_cubit.dart';
import 'package:td3_quiz_firebase/data/models/theme_model.dart';
import 'package:td3_quiz_firebase/presentation/pages/quiz_page.dart';
import 'package:td3_quiz_firebase/presentation/pages/update_questions_page.dart';

class QuestionItemContainer extends StatelessWidget {
  const QuestionItemContainer({
    Key? key,
    required this.state,
    required this.index,
  }) : super(key: key);

  final QuestionLoaded state;
  final int index;

  @override
  Widget build(BuildContext context) {
    void resetCubit(BuildContext c) {
      c.read<NextQuestionCubit>().reset();
      c.read<ScoreQuizCubit>().reset();
      c.read<AnswerQuestionCubit>().reset();
    }

    return Container(
          width: 350,
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 280,
                    padding: const EdgeInsets.all(10.0),
                    child: Text(state.questions.elementAt(index)!.question,
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                   
                    padding: const EdgeInsets.all(10.0),
                    child: Text(state.questions.elementAt(index)!.isTrue ? "Vrai" : "Faux",
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ))
            ],
          ));
  }
}
