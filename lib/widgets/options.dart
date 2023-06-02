import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_trivia/model/all_question.dart';
import 'package:flutter_trivia/utils/theme.dart';
import 'package:get/get.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget(
      {super.key,
      required this.id,
      required this.option,
      required this.onTap,
      required this.isCorrect,
      required this.isAnswered});
  final String id;
  final String option;
  final bool isAnswered;
  final bool isCorrect;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.borderColor),
          borderRadius: BorderRadius.circular(15),
          color: isAnswered
              ? isCorrect
                  ? AppTheme.right
                  : AppTheme.wrong
              : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        margin: const EdgeInsets.only(bottom: 14),
        child: Row(
          children: [
            Text(
              id,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isAnswered ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              "|",
              style: TextStyle(
                fontSize: 18,
                color: isAnswered ? Colors.white : AppTheme.borderColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: Get.width* 0.55,
              child: Text(
                option,
                style: TextStyle(
                  color: isAnswered ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
