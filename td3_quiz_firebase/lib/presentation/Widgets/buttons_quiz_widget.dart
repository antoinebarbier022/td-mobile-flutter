
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/bloc/question_bloc/question_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/answer_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/next_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/score_quiz_cubit.dart';

class ButtonsQuiz extends StatelessWidget {
  const ButtonsQuiz({
    Key? key, required this.state,
  }) : super(key: key);

  final QuestionLoaded state;

  void nextQuestion(BuildContext c, int index, int indexMax) {
      if (index + 1 == indexMax) {
        c.read<NextQuestionCubit>().reset();
        c.read<ScoreQuizCubit>().reset();
      } else {
        c.read<NextQuestionCubit>().next();
      }
      c.read<AnswerQuestionCubit>().reset();
    }

    void checkAnswer(BuildContext c, bool answer, bool userAnswer) {
      if (answer == userAnswer) {
        c.read<AnswerQuestionCubit>().correct();
        c.read<ScoreQuizCubit>().increment();
      } else {
        c.read<AnswerQuestionCubit>().incorrect();
        c.read<ScoreQuizCubit>().decrement();
      }
    }

  @override
  Widget build(BuildContext context) {
    return Container(
        // Container for Buttons
        width: 350,
        height: 50,
        child: BlocBuilder<NextQuestionCubit, int>(
            builder: (_, index) {
          return BlocBuilder<AnswerQuestionCubit, int>(
              builder: (_, answer) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: answer != 2
                      ? null
                      : () => checkAnswer(
                          context,
                          state.questions
                              .elementAt(index)!
                              .isTrue,
                          true),
                  child: const Text("Vrai",
                      style: TextStyle(fontSize: 18)),
                ),
                ElevatedButton(
                  // si c'est la fin du quiz on reset
                  onPressed: answer != 2
                      ? null
                      : () => checkAnswer(
                          context,
                          state.questions
                              .elementAt(index)!
                              .isTrue,
                          false),
                  child: const Text("Faux",
                      style: TextStyle(fontSize: 18)),
                ),
                ElevatedButton(
                  // si c'est la fin du quiz on reset
                  onPressed: answer == 2
                      ? null
                      : () => nextQuestion(context, index,
                          state.questions.length),
                  child: Wrap(
                    children: [
                      Text(
                          index + 1 == state.questions.length
                              ? "Recommencer"
                              : "Suivant",
                          style: const TextStyle(fontSize: 18)),
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  ),
                )
              ],
            );
          });
        }));
  }
}
