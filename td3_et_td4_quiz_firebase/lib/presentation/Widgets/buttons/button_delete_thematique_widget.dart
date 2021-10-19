
import 'package:flutter/material.dart';
import 'package:td3_quiz_firebase/data/models/theme_model.dart';
import 'package:td3_quiz_firebase/data/repositories/theme_repository.dart';
import 'package:td3_quiz_firebase/presentation/pages/home_page.dart';

class ButtonDelete extends StatelessWidget {
  const ButtonDelete({
    Key? key,
    required this.thematique,
  }) : super(key: key);

  final String thematique;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Supression du thème : $thematique'),
              content: Text("Voulez vous supprimer le thème $thematique ?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Non'),
                  child: const Text('Non'),
                ),

                TextButton(
                  onPressed: () {
                    final ThemeRepository repository = ThemeRepository();
                    repository.deleteTheme(thematique);

                    // on retourne à la page home
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage(
                                title: 'Thématiques',
                              )),
                    );
                  },
                  child: const Text('Oui'),
                ),
              ],
            ),
          ),
          child: const Icon(
            Icons.delete,
            size: 26.0,
          ),
        ));
  }
}
