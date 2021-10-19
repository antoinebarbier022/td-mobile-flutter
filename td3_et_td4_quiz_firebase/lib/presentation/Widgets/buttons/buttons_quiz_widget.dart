import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/bloc/question_bloc/question_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/answer_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/next_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/score_quiz_cubit.dart';
import 'package:td3_quiz_firebase/presentation/pages/home_page.dart';

class ButtonsQuiz extends StatelessWidget {
  const ButtonsQuiz({
    Key? key,
    required this.state,
  }) : super(key: key);

  final QuestionLoaded state;

  void resetCubit(BuildContext c) {
      c.read<NextQuestionCubit>().reset();
      c.read<ScoreQuizCubit>().reset();
      c.read<AnswerQuestionCubit>().reset();
    }

  void nextQuestion(BuildContext c, int index, int indexMax) {
    if (index + 1 == indexMax) {
      // Restart or return to menu
      //showFinishDialog(c);
      resetCubit(c);
    } else {
      // Next Question
      c.read<NextQuestionCubit>().next();
      c.read<AnswerQuestionCubit>().reset();
    }
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
    return SizedBox(
        // Container for Buttons
        width: 350,
        child: BlocBuilder<NextQuestionCubit, int>(builder: (_, index) {
          return BlocBuilder<AnswerQuestionCubit, int>(builder: (_, answer) {
            return Column(
              children: [
                if (answer == 2) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: answer != 2
                              ? null
                              : () => checkAnswer(
                                  context,
                                  state.questions.elementAt(index)!.isTrue,
                                  true),
                          child: const Text("Vrai",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          // si c'est la fin du quiz on reset
                          onPressed: answer != 2
                              ? null
                              : () => checkAnswer(
                                  context,
                                  state.questions.elementAt(index)!.isTrue,
                                  false),
                          child: const Text("Faux",
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(
                  width: 350,
                  child: (state.questions.length-1 == index) && (answer != 2)
                      ? ElevatedButton(
                          // Retour au menu
                          onPressed: () {
                            resetCubit(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage(
                                        title: 'Thématiques',
                                      )),
                            );
                          },
                          child: const Text("Retour au menu", style: TextStyle(fontSize: 18)),
                          )
                         : null,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 350,
                  child: answer == 2
                      ? null
                      : ElevatedButton(
                          // si c'est la fin du quiz on reset
                          onPressed: (answer == 2
                              ? null
                              : () => nextQuestion(
                                  context, index, state.questions.length)),
                          child: 
                              Text(
                                  state.questions.length-1 != index
                                      ? "Suivant"
                                      : "Recommencer",
                                  style: const TextStyle(fontSize: 18)),
                              
                        ),
                )
              ],
            );
          });
        }));
  }
}
