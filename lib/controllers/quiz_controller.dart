import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_trivia/controllers/history_controller.dart';
import 'package:flutter_trivia/model/all_question.dart';
import 'package:flutter_trivia/model/saved_file.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class QuizController extends GetxController {
  RxList<Question> questions = <Question>[].obs;
  RxBool isLoaded = false.obs;
  late PageController pageController;
  late HistoryController historyController;
  int currentQues = 1;
  RxBool isLocked = false.obs;
  RxList<bool> isAnswered = <bool>[].obs;
  RxList<String> allOptions = <String>[].obs;
  String correctAnswer = "";
  int score = 0;
  late Timer timer;
  RxInt sec = 0.obs;
  int maxSecond = 15;

  @override
  void onInit() {
    super.onInit();
    historyController = Get.put(HistoryController());
    pageController = PageController();
    resetTimer();
    loadQuestions();
  }

  @override
  void onClose() {
    pageController.dispose();
    stopTimer();
    super.onClose();
  }

  int questionLength() => questions.length;

  List<Question> getQuestions() => questions;

  int currentIndex() => currentQues;

  void setOptions() {
    allOptions.value = questions[currentQues - 1].incorrectAnswers;
    correctAnswer = questions[currentQues - 1].correctAnswer;
    isAnswered.value = List.filled(optionSize(), false);
  }

  void showAnswer(int index) {
    if (!isAnswered[index] && (!isLocked.value)) {
      stopTimer();
      isAnswered[index] = true;
      for (int i = 0; i < allOptions.length; i++) {
        if (allOptions[i] == correctAnswer) {
          isAnswered[i] = true;
          updateScore(i == index);
          break;
        }
      }
      isLocked(true);
      update();
    }
  }

  List<String> getOptions() => allOptions;

  int optionSize() => allOptions.length;

  int getScore() => score;

  void updateScore(bool isAdd) {
    if (isAdd) {
      score += 1;
    } else {
      score = score > 0 ? score - 1 : 0;
    }
  }

  void resetTimer() => sec.value = maxSecond;

  void stopTimer() => timer.cancel();

  void startTimer() {
    resetTimer();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (sec.value > 0) {
        sec.value--;
      } else {
        stopTimer();
        updateScore(false);
        nextQuestion();
      }
    });
  }

  void nextQuestion() {
    if (currentQues == questionLength()) {
      stopTimer();
      saveScore();
      Get.offAndToNamed("/result");
    } else {
      pageController.nextPage(
          duration: const Duration(milliseconds: 100), curve: Curves.linear);
      isLocked(false);
      currentQues += 1;
      setOptions();
      startTimer();
    }
    update();
  }

  void saveScore() {
    String date = DateFormat("dd/MM/yyyy").format(DateTime.now());
    historyController.saveTo(SavedFile(date: date, score: score));
  }

  Future<List<Question>> fetchQuestion() async {
    late http.Response response;
    try {
      response = await http.get(Uri.parse(
          "https://opentdb.com/api.php?amount=10&category=10&difficulty=easy&type=multiple"));
    } catch (e) {
      print(e);
    }
    print(response.body);
    return questionsResponseFromJson(response.body).questions;
  }

  void loadQuestions() async {
    questions.value = await fetchQuestion();
    if (questions.isNotEmpty) {
      setOptions();
      isLoaded(true);
      startTimer();
    }
    update();
  }
}
