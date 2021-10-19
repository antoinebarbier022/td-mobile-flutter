import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:td3_quiz_firebase/data/models/theme_model.dart';
import 'package:td3_quiz_firebase/presentation/pages/forms/formulaire_questions_page.dart';

class NoQuestionContainer extends StatelessWidget {
  const NoQuestionContainer({
    Key? key,
    required this.thematique,
  }) : super(key: key);

  final ThemeQuiz thematique;

  @override
  Widget build(BuildContext context) {
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
  }
}
