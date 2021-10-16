// ignore_for_file: file_names
class Question {
  final String question;
  final String thematique;
  final bool isTrue;

  Question({required this.question, required this.isTrue, required this.thematique,});


  bool valid(bool resp) {
    return resp == isTrue;
  }

  Map<String, dynamic> toJson() => _questionToJson(this);

  Question.fromJson(Map<String, dynamic> json)
      : this(
          question: json["question"] as String,
          isTrue: json["isTrue"] as bool,
          thematique: json["thematique"] as String,
        );

  @override
  String toString() => "Question: $question -> ($isTrue) : $thematique";

  Map<String, dynamic> _questionToJson(Question instance) => <String, dynamic>{
        'question': instance.question,
        'isTrue': instance.isTrue,
        'thematique' : instance.thematique
      };
}
