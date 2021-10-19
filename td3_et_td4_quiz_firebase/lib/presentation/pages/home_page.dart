import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/bloc/thematique_bloc/thematique_bloc.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/buttons/switch_dark_mode_widget.dart';
import 'package:td3_quiz_firebase/presentation/Widgets/items/item_thematique_container_widget.dart';
import 'package:td3_quiz_firebase/presentation/pages/forms/formulaire_theme_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThematiqueBloc>(context);
    themeBloc.add(GetAllThemes());

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false,
        actions: const <Widget>[
          SwitchDarkMode()
        ],
      ),
      body: BlocBuilder<ThematiqueBloc, ThematiqueState>(
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
                  return ThematiqueItemContainer(state: state, index: index);
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
                        builder: (context) => const FormulaireThemePage(
                              title: 'Ajouter un Quiz',
                            )),
                  );
        },
        child: const Icon(Icons.add)
      ),
    );
  }
}
