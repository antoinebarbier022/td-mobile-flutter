import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/bloc/question_bloc/question_bloc.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/buttons/button_delete_thematique_widget.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/items/item_question_container_widget.dart';
import 'package:td3_quiz_firebase/presentation/pages/forms/formulaire_questions_page.dart';

class UpdateQuestionsPage extends StatelessWidget {
  const UpdateQuestionsPage({Key? key, required this.thematique})
      : super(key: key);

  final String thematique;

  @override
  Widget build(BuildContext context) {
    final questionBloc = BlocProvider.of<QuestionBloc>(context);
    questionBloc.add(GetAllQuestionsForThematique(thematique));

    return Scaffold(
      appBar: AppBar(
        title: Text("Éditer le thème : $thematique"),
        actions: <Widget>[
          // Bouton pour supprimer la thématique
          ButtonDelete(thematique: thematique),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('questions')
            .where("thematique", isEqualTo: thematique)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error as String));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding:
                const EdgeInsets.only(bottom: 80, top: 10, left: 10, right: 10),
            reverse: false,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return QuestionItemContainer(data: document.data() as Map<String, dynamic>, id: document.id);
            }).toList(),
          );
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
          child: const Icon(Icons.add)),
    );
  }
}
