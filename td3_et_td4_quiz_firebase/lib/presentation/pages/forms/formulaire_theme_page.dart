import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/bloc/thematique_bloc/thematique_bloc.dart';
import 'package:td3_quiz_firebase/data/repositories/theme_repository.dart';
import 'package:td3_quiz_firebase/presentation/pages/home_page.dart';

class FormulaireThemePage extends StatelessWidget {
  const FormulaireThemePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0), child: const ThemeForm()));
  }
}

// Create a Form widget.
class ThemeForm extends StatefulWidget {
  const ThemeForm({Key? key}) : super(key: key);

  @override
  ThemeFormState createState() {
    return ThemeFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ThemeFormState extends State<ThemeForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<ThemeFormState>.
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _controllerNameTheme;
  late TextEditingController _controllerURLTheme;

  @override
  void initState() {
    super.initState();
    _controllerNameTheme = TextEditingController();
    _controllerURLTheme = TextEditingController();
  }

  @override
  void dispose() {
    _controllerNameTheme.dispose();
    _controllerURLTheme.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThematiqueBloc>(context);
    themeBloc.add(GetAllThemes());
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Theme input
          TextFormField(
            controller: _controllerNameTheme,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Entrer le nom de la thématique',
              labelText: 'Thème',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Le nom du thème est vide.';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          // URL input
          TextFormField(
            controller: _controllerURLTheme,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Lien de l\'image du thème',
              labelText: 'URL',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                final ThemeRepository repository = ThemeRepository();
                repository.addTheme(
                    _controllerNameTheme.text, _controllerURLTheme.text);

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
                  const SnackBar(content: Text('Ajout du thème')),
                );
              }
            },
            child: const Text('Créer la thématique'),
          ),
        ],
      ),
    );
  }
}
