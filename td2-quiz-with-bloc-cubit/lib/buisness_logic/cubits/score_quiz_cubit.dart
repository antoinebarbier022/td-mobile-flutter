import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreQuizCubit extends Cubit<int>{
  ScoreQuizCubit() : super(0);

  void increment() => emit(state+10);
  void decrement() => emit(state-5);
  void reset() => emit(0);

}