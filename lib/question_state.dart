import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_practice_3/answered_question.dart';
import 'package:flutter_practice_3/question.dart';
import 'package:flutter_practice_3/questions_service.dart';
import 'package:provider/provider.dart';

class QuestionState with ChangeNotifier {
  static QuestionState of(BuildContext context, {bool listen = true}) {
    return Provider.of<QuestionState>(context, listen: listen);
  }

  List<Question> _questions = [];
  int _currentQuestion = 0;
  List<AnsweredQuestion> _answered = [];
  bool _isLoading = false;
  String? _error;

  final QuestionService _questionService = QuestionService();

  QuestionState() {
    _getQuestions();
  }

  Question get currentQuestion {
    return _questions[_currentQuestion];
  }

  void userAnswered(bool usersAnswer) {
    if (hasFinished) {
      return;
    }
    AnsweredQuestion answeredQuestion = AnsweredQuestion(
      question: _questions[_currentQuestion],
      userAnswered: usersAnswer == _questions[_currentQuestion].isCorrect,
    );
    _answered.add(answeredQuestion);
    if (!isLastQuestion) {
      _currentQuestion++;
    }
    notifyListeners();
  }

  bool get isLastQuestion {
    return _currentQuestion == _questions.length - 1;
  }

  /// Initializes everything
  /// Is called when app starts
  /// or when user reloads
  void _getQuestions() async {
    try {
      _questions = [];
      _currentQuestion = 0;
      _answered = [];
      _isLoading = true;
      _error = null;
      notifyListeners();
      var questions = await _questionService.fetchQuestions();
      _questions = questions;
    } catch (error) {
      _error = "You have an error";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Starts a new question session by fetching new questions
  void restartQuestionaire() {
    _getQuestions();
  }

  /// Returns true if the user answered all the questions
  bool get hasFinished {
    return _questions.length == _answered.length;
  }

  /// The list of all answered questions
  /// by the user for each question
  List<AnsweredQuestion> get answers {
    return _answered;
  }

  bool get isLoading => _isLoading;

  String? get error => _error;
}
