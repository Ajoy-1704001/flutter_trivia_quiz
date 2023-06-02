import 'dart:convert';

class SavedFile {
  late final String date;
  late final int score;

  SavedFile({required this.date, required this.score});

  factory SavedFile.fromJson(Map<String, dynamic> jsonData) {
    return SavedFile(date: jsonData['date'], score: jsonData['score']);
  }

  static Map<String, dynamic> toMap(SavedFile sf) =>
      {'date': sf.date, 'score': sf.score};

  static String encode(List<SavedFile> sf) => json.encode(
        sf.map<Map<String, dynamic>>((e) => SavedFile.toMap(e)).toList(),
      );

  static List<SavedFile> decode(String sf) => (json.decode(sf) as List<dynamic>)
      .map<SavedFile>((item) => SavedFile.fromJson(item))
      .toList();
}
