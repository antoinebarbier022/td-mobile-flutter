import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/bloc/question_bloc/question_bloc.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/buttons/button_delete_thematique_widget.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/items/question_item_container_widget.dart';
import 'package:td3_quiz_firebase/presentation/pages/forms/formulaire_questions_page.dart';



class UpdateQuestionsPage extends StatelessWidget {
  const UpdateQuestionsPage({Key? key, required this.thematique}) : super(key: key);

  final String thematique;

  @override
  Widget build(BuildContext context) {
    final questionBloc = BlocProvider.of<QuestionBloc>(context);
    questionBloc.add(GetAllQuestionsForThematique(thematique));

    return Scaffold(
      appBar: AppBar(
        title: Text("Éditer le thème : $thematique"),
        actions:<Widget>[
          // Bouton pour supprimer la thématique
          ButtonDelete(thematique: thematique),
        ],
      ),
      body: BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, state) {
          if (state is QuestionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is QuestionLoaded) {
            return 
                ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80, top: 10, left: 10, right: 10),
                    reverse: false,
                    itemCount: state.questions.length,
                    itemBuilder: (_, int index) {
                      return QuestionItemContainer(state: state, index: index);
                    });
          } else {
            return const Center(child: Text("Aucune Thématique."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormulaireQuestionsPage(
                              thematique: thematique,
                            )),
                  );
        },
        child: const Icon(Icons.add)
      ),
    );
  }
}
