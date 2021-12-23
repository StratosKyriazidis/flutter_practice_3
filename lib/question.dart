import 'dart:convert';

class Question {
  final String questionText;
  final bool isCorrect;

  Question({
    required this.questionText,
    required this.isCorrect,
  });

  Question copyWith({
    String? questionText,
    bool? isCorrect,
  }) {
    return Question(
      questionText: questionText ?? this.questionText,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'isCorrect': isCorrect,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionText: map['question'] ?? '',
      isCorrect: map['correct_answer'] == "True",
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() =>
      'Question(questionText: $questionText, isCorrect: $isCorrect)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Question &&
        other.questionText == questionText &&
        other.isCorrect == isCorrect;
  }

  @override
  int get hashCode => questionText.hashCode ^ isCorrect.hashCode;
}
