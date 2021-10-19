import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/bloc/thematique_bloc/theme_bloc.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/thematique_item_container_widget.dart';
import 'package:td3_quiz_firebase/presentation/pages/formulaire_theme_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    themeBloc.add(GetAllThemes());

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FormulaireThemePage(title: 'Ajouter un Quiz',)),
                          );
                },
                child: const Icon(
                  Icons.add,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ThemeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ThemeLoaded) {
            return ListView.builder(
                padding: const EdgeInsets.all(20.0),
                reverse: false,
                itemCount: state.getThemes.length,
                itemBuilder: (_, int index) {
                  return ThematiqueItemContainer(state : state, index: index);
                });
          } else {
            return const Center(child: Text("Aucune Thématique."));
          }
        },
      ),
    );
  }
}

