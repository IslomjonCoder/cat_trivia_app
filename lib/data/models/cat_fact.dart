import 'package:cat_trivia_app/utils/constants/api_constants.dart';
import 'package:hive/hive.dart';

part 'cat_fact.g.dart';

@HiveType(typeId: 0)
class CatFact {
  @HiveField(0)
  String text;

  @HiveField(1)
  DateTime creationDate;

  @HiveField(2)
  String imageUrl;

  CatFact({required this.text, required this.creationDate, this.imageUrl = baseUrlImage});

  factory CatFact.fromJson(Map<String, dynamic> map) {
    return CatFact(
      text: map['text'] as String,
      creationDate: DateTime.now(),
    );
  }
}
