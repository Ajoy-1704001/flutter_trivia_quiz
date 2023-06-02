import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_trivia/controllers/history_controller.dart';
import 'package:flutter_trivia/utils/theme.dart';
import 'package:flutter_trivia/widgets/bacn_button.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
          init: HistoryController(),
          builder: (controller) {
            if (controller.sfList.isEmpty) {
              return const Center(
                child: Text("Nothing Found"),
              );
            }
            return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: controller.getLength(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppTheme.borderColor)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Date",
                                  style: TextStyle(color: Colors.deepPurple),
                                ),
                                Text(
                                  controller.sfList[index].date,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 19),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Score",
                                  style: TextStyle(
                                      color: controller.sfList[index].score > 0
                                          ? AppTheme.right
                                          : AppTheme.wrong),
                                ),
                                Text(
                                  "${controller.sfList[index].score}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 19),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
