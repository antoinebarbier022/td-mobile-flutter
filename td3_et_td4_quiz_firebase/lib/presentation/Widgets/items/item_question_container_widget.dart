import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:td3_quiz_firebase/data/repositories/question_repository.dart';
// ignore: implementation_imports

class QuestionItemContainer extends StatelessWidget {
  const QuestionItemContainer({
    Key? key,
    required this.data,
    required this.id,
  }) : super(key: key);

  final String id;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    QuestionRepository repository = QuestionRepository();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
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
                      child: Text(data["question"],
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(data["isTrue"] ? "Vrai" : "Faux",
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.bold)),
                    ),
                    
                  ],
                )
              ],
            )),
            IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      color: Colors.red,
                      onPressed: () => {
                        repository.deleteQuestion(id).then((value){
                            ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Question supprimé !')),
                );
                        })
                        
                      }
                )
      ],
    );
  }
}
