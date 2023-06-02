import 'dart:convert';

AllQuestion questionsResponseFromJson(String str) =>
    AllQuestion.fromJson(json.decode(str));

class AllQuestion {
  AllQuestion({
    required this.responseCode,
    required this.questions,
  });
  late final int responseCode;
  late final List<Question> questions;

  AllQuestion.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    questions =
        List.from(json['results']).map((e) => Question.fromJson(e)).toList();
  }
}

class Question {
  Question(
      {required this.question,
      required this.correctAnswer,
      required this.incorrectAnswers});
  late final String question;
  late final String correctAnswer;
  late final List<String> incorrectAnswers;

  Question.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    correctAnswer = json['correct_answer'];
    incorrectAnswers =
        List.castFrom<dynamic, String>(json['incorrect_answers']);
    incorrectAnswers.add(correctAnswer);
    incorrectAnswers.shuffle();
  }
}

class Option {
  late final String title;
  late bool isAnswered;
  late bool isCorrect;

  Option(
      {required this.title, this.isAnswered = false, required this.isCorrect});

  void setAnswer() => isAnswered = true;
}
