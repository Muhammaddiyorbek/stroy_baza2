import 'package:dio/dio.dart';
import 'package:stroy_baza/app_constats/app_url.dart';
import 'package:stroy_baza/models/product.dart';

class ProductRepository {
  final Dio _dio = Dio();

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('${AppUrl.base}/api/api/products/');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }
}
