import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:td3_quiz_firebase/buisness_logic/bloc/question_bloc/question_bloc.dart';

class QuestionItemContainer extends StatelessWidget {
  const QuestionItemContainer({
    Key? key,
    required this.state,
    required this.index,
  }) : super(key: key);

  final QuestionLoaded state;
  final int index;

  @override
  Widget build(BuildContext context) {

    return Container(
          width: 350,
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Container(
                width: 280,
                padding: const EdgeInsets.all(10.0),
                child: Text(state.questions.elementAt(index)!.question,
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
               
                padding: const EdgeInsets.all(10.0),
                child: Text(state.questions.elementAt(index)!.isTrue ? "Vrai" : "Faux",
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.bold)),
              ),
                ],
              )
            ],
          ));
  }
}
