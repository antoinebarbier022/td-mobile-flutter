import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:td3_quiz_firebase/data/models/question_model.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;


class QuestionProvider {

  // --- COLLECTION REFERENCE ---
  static CollectionReference getGroupCollection() {
    return firestore.collection('questions');
  }

  // --- GET ALL ---
  Query getAllQuestions() {
    return QuestionProvider.getGroupCollection().withConverter<Question>(
      fromFirestore: (snapshot, _) => Question.fromJson(snapshot.data()!),
      toFirestore: (question, _) => question.toJson(),
    );
  }

  // --- GET ALL BY CATEGORIES ---
  Query getAllQuestionsByThematique(String thematique) {
    return QuestionProvider.getGroupCollection()
        .where("thematique", isEqualTo: thematique).withConverter<Question>(
      fromFirestore: (snapshot, _) => Question.fromJson(snapshot.data()!),
      toFirestore: (question, _) => question.toJson(),
    );
  }

  // --- GET ---
  Future<DocumentSnapshot<Object?>> getQuestion(String id) {
    return QuestionProvider.getGroupCollection().doc(id).get();
  }

  // --- ADD ---
  Future<void> addQuestion(Question newQuestion) async {
    return QuestionProvider.getGroupCollection()
        .doc()
        .set(newQuestion.toJson());
  }

  // --- DELETE ---
  Future<void> deleteQuestion(String id) async {
    return QuestionProvider.getGroupCollection().doc(id).delete();
  }

  // --- DELETE QUESTION FOR THEME ---
  Future<void> deleteQuestionsTheme(String id) async {
    return QuestionProvider.getGroupCollection().doc(id).delete();
  }
}
