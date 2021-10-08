import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quiz/buisness_logic/cubits/answer_question_cubit.dart';
import 'package:quiz/buisness_logic/cubits/next_question_cubit.dart';
import 'package:quiz/buisness_logic/cubits/score_quiz_cubit.dart';
import 'package:quiz/data/models/game.dart';

class MyQuizPage extends StatelessWidget {
  MyQuizPage({Key? key, required this.title}) : super(key: key);

  // On lance une partie
  final game = Game();

  final String title;

  @override
  Widget build(BuildContext context) {
    var _resultQuestion = 2;

    void nextQuestion(BuildContext c, int index) {
      if (index + 1 == game.getNbQuestions()) {
        c.read<NextQuestionCubit>().reset();
        c.read<ScoreQuizCubit>().reset();
      } else {
        c.read<NextQuestionCubit>().next();
      }
      c.read<AnswerQuestionCubit>().reset();
    }

    void checkAnswer(BuildContext c, int index, bool answer) {
      if (game.questionValidation(index, answer)) {
        c.read<AnswerQuestionCubit>().correct();
        c.read<ScoreQuizCubit>().increment();
      } else {
        c.read<AnswerQuestionCubit>().incorrect();
        c.read<ScoreQuizCubit>().decrement();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
                // Container for Header (score and index)
                width: 350,
                height: 50,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<NextQuestionCubit, int>(
                      builder: (_, index) {
                        return Center(
                          child: Text(
                              'Question ${index + 1}/${game.getNbQuestions()}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        );
                      },
                    ),
                    BlocBuilder<ScoreQuizCubit, int>(
                      builder: (_, score) {
                        return Center(
                            child: Text('Score : $score',
                                style: const TextStyle(fontSize: 18)));
                      },
                    ),
                  ],
                )),
            const SizedBox(height: 10),
            Container(
                // Container for Image
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Image(
                  image: NetworkImage(
                      "https://images.assetsdelivery.com/compings_v2/soifer/soifer1809/soifer180900063.jpg"),
                )),
            const SizedBox(height: 20),
            BlocBuilder<NextQuestionCubit, int>(
              builder: (_, index) {
                return BlocBuilder<AnswerQuestionCubit, int>(
                    builder: (_, answer) {
                  return Container(
                      // Container for Questions
                      width: 350,
                      height: 150,
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2.0,
                            color: answer == 2
                                ? Colors.blueGrey.shade200
                                : (answer == 1 ? Colors.green : Colors.red),
                          )),
                      child: Text(
                        game.getQuestion(index),
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ));
                });
              },
            ),
            const SizedBox(height: 40),
            Container(
                // Container for Buttons
                width: 350,
                height: 50,
                child: BlocBuilder<NextQuestionCubit, int>(builder: (_, index) {
                  return BlocBuilder<AnswerQuestionCubit, int>(
                      builder: (_, answer) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: answer != 2
                              ? null
                              : () => checkAnswer(context, index, true),
                          child: const Text("Vrai",
                              style: TextStyle(fontSize: 18)),
                        ),
                        ElevatedButton(
                          // si c'est la fin du quiz on reset
                          onPressed: answer != 2
                              ? null
                              : () => checkAnswer(context, index, false),
                          child: const Text("Faux",
                              style: TextStyle(fontSize: 18)),
                        ),
                        ElevatedButton(
                          // si c'est la fin du quiz on reset
                          onPressed: answer == 2
                              ? null
                              : () => nextQuestion(context, index),
                          child: Wrap(
                            children: [
                              Text(
                                  index + 1 == game.getNbQuestions()
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
                })),
          ],
        ),
      ),
    );
  }
}
