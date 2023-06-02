import 'package:flutter_trivia/model/saved_file.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryController extends GetxController {
  late final SharedPreferences prefs;
  RxList<SavedFile> sfList = <SavedFile>[].obs;

  int getLength() => sfList.length;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    readFile();
  }

  void saveTo(SavedFile sf) async {
    sfList.add(sf);
    String encoded = SavedFile.encode(sfList);
    await prefs.setString('history', encoded);
  }

  void readFile() async {
    final String? sfString = prefs.getString('history');
    if (sfString != null) {
      sfList.value = SavedFile.decode(sfString);
      update();
    }
  }
}
