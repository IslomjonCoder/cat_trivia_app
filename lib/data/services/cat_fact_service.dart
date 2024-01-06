import 'package:cat_trivia_app/data/models/cat_fact.dart';
import 'package:cat_trivia_app/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';

class CatFactService {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<CatFact> getRandomCatFact() async {
    try {
      final response = await _dio.get('/facts/random', queryParameters: queryParams);
      if (response.statusCode == 200) {
        return CatFact.fromJson(response.data as Map<String, dynamic>);
      }
      throw 'Request failed with status: ${response.statusCode}.';
    } catch (e) {
      rethrow;
    }
  }
}
