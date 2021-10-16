import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/bloc/thematique_bloc/theme_bloc.dart';
import 'package:td3_quiz_firebase/data/repositories/question_repository.dart';
import 'package:td3_quiz_firebase/presentation/pages/home_page.dart';

class FormulaireQuestionsPage extends StatelessWidget {
  const FormulaireQuestionsPage({Key? key, required this.thematique}) : super(key: key);

  final String thematique;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nouvelle question ($thematique)"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0), child:  QuestionForm(thematique: thematique)));
  }
}

// Create a Form widget.
class QuestionForm extends StatefulWidget {
  const QuestionForm({Key? key, required this.thematique}) : super(key: key);

  final String thematique;
  @override
  QuestionFormState createState() {
    return QuestionFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class QuestionFormState extends State<QuestionForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<QuestionFormState>.
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _controllerQuestion;

  bool isSwitched = false;
  @override
  void initState() {
    super.initState();
    _controllerQuestion = TextEditingController();
  }

  @override
  void dispose() {
    _controllerQuestion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    themeBloc.add(GetAllThemes());
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Theme input
          TextFormField(
            controller: _controllerQuestion,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Entrer la question',
              labelText: 'Question',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La question est vide.';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),

          Row(
            children: [
              const Text("Réponse "),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    print(isSwitched);
                  });
                },),
            ],
          ),
          
          
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                final QuestionRepository repository = QuestionRepository();
                repository.addQuestion(
                    _controllerQuestion.text, isSwitched, widget.thematique);

                // on get tous les thèmes pour mettre à jour le bloc
                themeBloc.add(GetAllThemes());

                // on retourne à la page home
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage(
                            title: 'Thématiques',
                          )),
                );

                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ajout de la question')),
                );
              }
            },
            child: const Text('Créer la question'),
          ),
        ],
      ),
    );
  }
}
