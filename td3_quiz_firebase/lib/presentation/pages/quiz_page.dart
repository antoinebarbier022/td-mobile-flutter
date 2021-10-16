import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/bloc/question_bloc/question_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/answer_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/next_question_cubit.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/score_quiz_cubit.dart';
import 'package:td3_quiz_firebase/data/models/theme_model.dart';
import 'package:td3_quiz_firebase/data/repositories/question_repository.dart';
import 'package:td3_quiz_firebase/data/repositories/theme_repository.dart';
//import 'package:td3_quiz_firebase/data/repositories/questions_repository.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/image_quiz_widget.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/index_quiz_widget.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/score_quiz_widget.dart';
import 'package:td3_quiz_firebase/presentation/pages/formulaire_questions_page.dart';
import 'package:td3_quiz_firebase/presentation/pages/home_page.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz : ${thematique.nom}"),
        actions: <Widget>[
          Padding(
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
              )),
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Supression pour le thème : ${thematique.nom}'),
                    content: const Text(
                        "Vous avez le choix entre supprimer la question et supprimer le thème. (La suppression de la question n'est pas encore implémenté)"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Annuler'),
                      ),
                      /*
                      BlocBuilder<QuestionBloc, QuestionState>(
                        builder: (context, state) {
                          if (state is QuestionLoaded) {
                            return TextButton(
                              // supprimer la question
                              onPressed: () {
                                final QuestionRepository repository =
                                    
                                //repository.deleteQuestion(thematique.nom);

                                // on retourne à la page home
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage(
                                            title: 'Thématiques',
                                          )),
                                );
                              },
                              child: const Text('Supprimer la question'),
                            );
                          }else{
                            return Container();
                          }
                        },
                      ),*/
                      TextButton(
                        onPressed: () {
                          final ThemeRepository repository = ThemeRepository();
                          repository.deleteTheme(thematique.nom);

                          // on retourne à la page home
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage(
                                      title: 'Thématiques',
                                    )),
                          );
                        },
                        child: const Text('Supprimer le thème'),
                      ),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.delete,
                  size: 26.0,
                ),
              )),
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
                          children: const [
                            IndexQuiz(), // index du jeu (numéro question en cours)
                            ScoreQuiz(), // Score du jeu
                          ],
                        )),
                    const SizedBox(height: 10),
                    ImageQuiz(url: thematique.getUrl()), // image quiz
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
                                        : (answer == 1
                                            ? Colors.green
                                            : Colors.red),
                                  )),
                              child: BlocBuilder<QuestionBloc, QuestionState>(
                                builder: (context, state) {
                                  if (state is QuestionLoading) {
                                    // Chargement
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (state is QuestionLoaded) {
                                    return Text(
                                      state.getQuestions
                                          .elementAt(0)!
                                          .question
                                          .toString(), // state.getQuestions.first.toString(),  //game.getQuestion(index),
                                      style: const TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    );
                                  } else if (state is QuestionNotLoaded) {
                                    return const Center(
                                        child: Text("Aucun résultats"));
                                  }
                                  return const Center(
                                      child: Text("Aucun résultats"));
                                },
                              ));
                        });
                      },
                    ),
                    const SizedBox(height: 40),
                    Container(
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
                        })),
                  ],
                ),
              );
            }
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text("Il n'y a pas encore de questions dans ce quiz."),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // on va sur le formulaire ajout de question
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormulaireQuestionsPage(
                                    thematique: thematique.nom,
                                  )),
                        );
                      },
                      child: const Text("Ajouter une question")),
                ]));
          },
        ),
      ),
    );
  }
}
