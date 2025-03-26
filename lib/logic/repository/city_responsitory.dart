import 'package:dio/dio.dart';
import 'package:stroy_baza/models/city_select.dart';

class CityRepository {
  final Dio _dio = Dio();

  Future<List<City>> fetchCities() async {
    try {
      final response = await _dio.get('https://back.stroybazan1.uz/api/api/cities/');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => City.fromJson(json)).toList();
      } else {
        throw Exception('Xatolik: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Shaharlarni yuklashda xatolik: $e');
    }
  }
}
