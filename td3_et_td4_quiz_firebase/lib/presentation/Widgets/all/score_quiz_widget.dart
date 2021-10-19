
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:td3_quiz_firebase/buisness_logic/cubits/score_quiz_cubit.dart';

class ScoreQuiz extends StatelessWidget {
  const ScoreQuiz({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreQuizCubit, int>(
      builder: (_, score) {
        return Center(
            child: Text('Score : $score',
                style: const TextStyle(fontSize: 18)));
      },
    );
  }
}

