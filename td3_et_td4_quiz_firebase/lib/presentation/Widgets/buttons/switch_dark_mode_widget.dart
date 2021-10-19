
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/theme_mode_cubit.dart';

class SwitchDarkMode extends StatelessWidget {
  const SwitchDarkMode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (_, themeMode) {
        return Switch(
          value: themeMode == ThemeMode.dark || ThemeMode.system == ThemeMode.dark,
          onChanged: (value) => context.read<ThemeCubit>().switchTheme(),
        );
      },
    );
  }
}
