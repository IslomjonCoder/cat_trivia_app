import 'package:cat_trivia_app/data/models/cat_fact.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class LocalService {
  static const String _catFactsBoxName = 'catFacts';

  Future<void> initializeHive() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(CatFactAdapter());
    await Hive.openBox<CatFact>(_catFactsBoxName);
  }

  Future<void> openBox() async {
    await Hive.openBox<CatFact>(_catFactsBoxName);
  }

  Box<CatFact> getCatFactsBox() {
    return Hive.box<CatFact>(_catFactsBoxName);
  }

  void saveCatFact(CatFact catFact) {
    final catFactsBox = getCatFactsBox();
    catFactsBox.add(catFact);
  }

  List<CatFact> getAllCatFacts() {
    final catFactsBox = getCatFactsBox();
    return catFactsBox.values.toList();
  }
}
