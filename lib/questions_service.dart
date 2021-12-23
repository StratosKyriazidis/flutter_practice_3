import 'package:dio/dio.dart';
import 'package:flutter_practice_3/question.dart';

class QuestionService {
  static final QuestionService instance = QuestionService._();

  /// var service = QuestionService();
  /// equals
  /// var service = QuestionService.instance;
  factory QuestionService() {
    return instance;
  }

  QuestionService._();
  Future<List<Question>> fetchQuestions() async {
    var response = await Dio().get<Map<String, dynamic>>(
        'https://opentdb.com/api.php?amount=10&type=boolean');
    var data = response.data;
    if (data == null) {
      return [];
    }
    var results = List<dynamic>.from(data['results'] ?? []);
    var questions = <Question>[];
    for (var qData in results) {
      var q = Question.fromMap(Map<String, dynamic>.from(qData));
      questions.add(q);
    }

    return questions;
  }
}
