// ignore_for_file: file_names

class Question{
  String? question;
  bool? isTrue;

  Question(this.question, this.isTrue);

  bool valid(bool resp){
    return resp == isTrue;
  }
}