import 'package:flutter/material.dart';
import 'package:flutter_trivia/controllers/quiz_controller.dart';
import 'package:flutter_trivia/model/all_question.dart';
import 'package:flutter_trivia/utils/theme.dart';
import 'package:flutter_trivia/widgets/bacn_button.dart';
import 'package:flutter_trivia/widgets/button.dart';
import 'package:flutter_trivia/widgets/options.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  //QuizController controller = Get.put(QuizController());
  var alphabets = ['A', 'B', 'C', 'D', 'E'];
  @override
  void initState() {
    super.initState();
    //controller.loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.scaffoldColor,
        appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: AppTheme.scaffoldColor,
            titleTextStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
            title: const Text("Trivia Quiz"),
            leading: const backButton()),
        body: GetBuilder(
          init: QuizController(),
          builder: (controller) {
            List<Question> questions = controller.getQuestions();
            if (questions.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      questionCounter(controller.currentIndex(),
                          controller.questionLength()),
                      Row(
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            color: Colors.red,
                          ),
                          Obx(() => Text(
                                "0:${controller.sec.value} sec",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 16),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: Get.height * 0.8,
                  child: PageView.builder(
                      controller: controller.pageController,
                      itemCount: controller.questionLength(),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              questionPreview(questions[index].question),
                              const SizedBox(
                                height: 20,
                              ),
                              for (int i = 0; i < controller.optionSize(); i++)
                                OptionWidget(
                                  id: alphabets[i],
                                  option: controller.getOptions()[i],
                                  onTap: () {
                                    controller.showAnswer(i);
                                  },
                                  isAnswered: controller.isAnswered[i],
                                  isCorrect: controller.correctAnswer ==
                                      controller.getOptions()[i],
                                ),
                              const Spacer(),
                              controller.isLocked.value
                                  ? Button(
                                      onTap: () {
                                        controller.nextQuestion();
                                      },
                                      title: controller.currentQues ==
                                              controller.questionLength()
                                          ? "See Score"
                                          : "Next",
                                      borderRadius: 15,
                                      color: AppTheme.nextBtn)
                                  : Container(),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            );
          },
        ));
  }

  Widget questionCounter(int index, int totalQues) {
    return Text(
      "Question $index/$totalQues",
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
    );
  }

  Widget questionPreview(String ques) {
    return Container(
      width: Get.width,
      height: Get.width * 0.55,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/ques_bg.jpg"),
          )),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Center(
        child: Text(
          HtmlUnescape().convert(ques),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24),
          textAlign: TextAlign.center,
          // overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
