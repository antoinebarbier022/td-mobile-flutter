import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:td3_quiz_firebase/data/dataproviders/question_provider.dart';
import 'package:td3_quiz_firebase/data/models/question_model.dart';

class QuestionRepository {
  QuestionRepository({Key? key});
  final _questionProvider = QuestionProvider();

  Stream<QuerySnapshot> getAllQuestions() =>
      _questionProvider.getAllQuestions().snapshots();


  Stream<QuerySnapshot> getAllQuestionsByThematique(String thematique) => 
      _questionProvider.getAllQuestionsByThematique(thematique).snapshots();


  Future<List<Question?>> getQuestionsList() async {
        return _questionProvider.getAllQuestions().get().then((snapshot){
          final List<Question?> questions = [];
          for (var doc in snapshot.docs) {
            questions.add(doc.data() as Question);
          }
          return questions;
        });
  } 

    Future<List<Question?>> getQuestionsThematiqueList(String thematique) async {
        return _questionProvider.getAllQuestionsByThematique(thematique).get().then((snapshot){
          final List<Question?> questions = [];
          for (var doc in snapshot.docs) {
            questions.add(doc.data() as Question);
          }
          return questions;
        });
  } 
  


  Future<DocumentSnapshot> getQuestion(String id) async =>
      await _questionProvider.getQuestion(id);

  Future<void> addQuestion(String question, bool isTrue, String thematique) async =>
      await _questionProvider.addQuestion(Question(question: question, isTrue: isTrue, thematique: thematique));

  Future<void> deleteQuestion(String id) async =>
      await _questionProvider.deleteQuestion(id);

      
}
