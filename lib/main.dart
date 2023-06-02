import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_trivia/views/history.dart';
import 'package:flutter_trivia/views/home.dart';
import 'package:flutter_trivia/views/quiz_screen.dart';
import 'package:flutter_trivia/views/show_result.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Trivia Quiz',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.poppins().fontFamily),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Home()),
        GetPage(name: '/startQuiz', page: () => const QuizScreen()),
        GetPage(name: '/result', page: () => const Result()),
        GetPage(name: '/history', page: () => const History()),
      ],
    );
  }
}
