import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/bloc/question_bloc/question_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/answer_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/next_question_cubit.dart';
import 'package:td3_quiz_firebase/data/models/theme_model.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/all/image_quiz_widget.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/all/index_quiz_widget.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/all/noquestion_container_widget.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/all/score_quiz_widget.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/buttons/buttons_quiz_widget.dart';
//import 'package:td3_quiz_firebase/data/repositories/question_repository.dart';

//import 'package:td3_quiz_firebase/data/repositories/questions_repository.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/buttons/switch_dark_mode_widget.dart';
import 'package:td3_quiz_firebase/presentation/pages/forms/formulaire_questions_page.dart';


class QuizPage extends StatelessWidget {
  const QuizPage({Key? key, required this.thematique}) : super(key: key);

  final ThemeQuiz thematique;

  @override
  Widget build(BuildContext context) {
    final questionBloc = BlocProvider.of<QuestionBloc>(context);
    questionBloc.add(GetAllQuestionsForThematique(thematique.nom));

/*
    final QuestionsRepository repository = QuestionsRepository();

    repository.addQuestion("Prince Harry is taller than Prince William.", false, "Histoire");
    repository.addQuestion("The star sign Aquarius is represented by a tiger.", true, "Histoire");
    repository.addQuestion("Meryl Streep has won two Academy Awards.", false, "Histoire");
    repository.addQuestion("Marrakesh is the capital of Morocco.", false, "Histoire");
    repository.addQuestion("Idina Menzel sings 'let it go' 20 times in 'Let It Go' from Frozen ?", false, "Histoire");
    repository.addQuestion("Waterloo has the greatest number of tube platforms in London.", true, "Histoire");
    repository.addQuestion("M&M stands for Mars and Moordale.", false, "Histoire");
    repository.addQuestion("Gin is typically included in a Long Island Iced Tea.", true, "Histoire");
    repository.addQuestion("The unicorn is the national animal of Scotland", true, "Histoire");
    repository.addQuestion("There are two parts of the body that can't heal themselves", false, "Histoire");
*/

    double valueProgressBar(int answer, int index, int indexMax) {
      return answer == 2 ? (index) / indexMax : (index+1) / indexMax;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz : ${thematique.nom}"),
        actions: const <Widget>[
          SwitchDarkMode(),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<QuestionBloc, QuestionState>(
          builder: (context, state) {
            if (state is QuestionLoading) {
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                    SizedBox(
                      height: 30,
                    ),
                    CircularProgressIndicator()
                  ]));
            }
            if (state is QuestionLoaded) {
              return Center(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  width: 400,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Container for Header (score and index)
                        Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                IndexQuiz(), // index du jeu (num??ro question en cours)
                                ScoreQuiz(), // Score du jeu
                              ],
                            )),
                        const SizedBox(height: 10),
                        BlocBuilder<AnswerQuestionCubit, int>(
                          builder: (_, answer) {
                            return BlocBuilder<NextQuestionCubit, int>(
                              builder: (_, index) {
                                return ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: valueProgressBar(
                                        answer, index, state.questions.length),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        // image de la th??matique du quiz
                        ImageQuiz(url: thematique.getUrl()),
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
                                      color: answer == 2
                                          ? Colors.transparent
                                          : (answer == 1
                                              ? Colors.green.shade100
                                              : Colors.red.shade100),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 2.0,
                                        color: answer == 2
                                            ? Colors.blueGrey.shade200
                                            : (answer == 1
                                                ? Colors.green
                                                : Colors.red),
                                      )),
                                  child:
                                      BlocBuilder<QuestionBloc, QuestionState>(
                                    builder: (context, state) {
                                      if (state is QuestionLoading) {
                                        // Chargement
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (state is QuestionLoaded) {
                                        return Text(
                                          state.getQuestions
                                              .elementAt(index)!
                                              .question
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: answer == 2
                                                ? Theme.of(context).hintColor
                                                : Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        );
                                      } else if (state is QuestionNotLoaded) {
                                        return const Center(
                                            child: Text("Aucun r??sultats"));
                                      }
                                      return const Center(
                                          child: Text("Aucun r??sultats"));
                                    },
                                  ));
                            });
                          },
                        ),
                        const SizedBox(height: 40),
                        // Les boutons vrai, faux, suivant
                        ButtonsQuiz(state: state),
                      ],
                    ),
                  ),
                ),
              );
            }
            // Si il n'y a pas de questions, on affiche un message et un bouton pour ajouter une question
            return NoQuestionContainer(thematique: thematique);
          },
        ),
      ),
    );
  }
}

class ButtonToFormQuestionPage extends StatelessWidget {
  const ButtonToFormQuestionPage({
    Key? key,
    required this.thematique,
  }) : super(key: key);

  final ThemeQuiz thematique;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FormulaireQuestionsPage(
                      thematique: thematique.nom,
                    )),
          ),
          child: const Icon(
            Icons.add,
            size: 26.0,
          ),
        ));
  }
}
