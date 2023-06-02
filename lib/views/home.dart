import 'package:flutter/material.dart';
import 'package:flutter_trivia/utils/theme.dart';
import 'package:flutter_trivia/widgets/button.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                Image(
                    width: Get.width * 0.7,
                    image: const AssetImage("images/quiz.png")),
                const SizedBox(
                  height: 20,
                ),
                Button(
                  onTap: () {
                    Get.toNamed('/startQuiz');
                  },
                  title: "Start Quiz",
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
          ),
        ],
      ),
    );
  }
}
