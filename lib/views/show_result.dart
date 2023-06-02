import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_trivia/controllers/quiz_controller.dart';
import 'package:flutter_trivia/utils/theme.dart';
import 'package:flutter_trivia/widgets/button.dart';
import 'package:get/get.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  QuizController controller = Get.find();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image(
          image: const AssetImage("images/bg.png"),
          height: Get.height,
          fit: BoxFit.cover,
          opacity: const AlwaysStoppedAnimation(.15),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Your Score",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${controller.getScore()}",
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple.shade800),
              ),
              const SizedBox(
                height: 10,
              ),
              Button(
                onTap: () {
                  Get.offAndToNamed("/startQuiz");
                },
                title: "Play Again",
                color: AppTheme.primary,
                width: Get.width * 0.7,
                borderRadius: 12,
              ),
              const SizedBox(
                height: 12,
              ),
              Button(
                onTap: () {
                  Get.toNamed("/history");
                },
                title: "View History",
                color: AppTheme.secondary,
                width: Get.width * 0.7,
                borderRadius: 12,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
