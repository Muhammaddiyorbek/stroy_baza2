import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stroy_baza/core/services/local_storage_helper.dart';
import 'package:stroy_baza/models/orderItemRequestModel.dart';

class CartRepository {
  final String baseUrl;

  CartRepository({required this.baseUrl});

  Future<int?> addToCart(OrderItemRequestModel data) async {
    // final orderId = await LocalStorageHelper.getOrderId();
    // final url = Uri.parse('$baseUrl/api/add-to-cart');
    //
    // final response = await http.post(
    //   url,
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({
    //     ...data.toJson(),
    //     if (orderId != null) 'order_id': orderId,
    //   }),
    // );
    //
    // if (response.statusCode == 200) {
    //   final json = jsonDecode(response.body);
    //   final newOrderId = json['order_id'];
    //   if (orderId == null && newOrderId != null) {
    //     await LocalStorageHelper.saveOrderId(newOrderId);
    //   }
    //   return newOrderId;
    // } else {
    //   throw Exception('Failed to add to cart');
    // }
  }

  Future<List<dynamic>> fetchCartItems() async {
    return [];
    // final orderId = await LocalStorageHelper.getOrderId();
    // if (orderId == null) return [];
    //
    // final url = Uri.parse('$baseUrl/api/cart/$orderId');
    // final response = await http.get(url);
    //
    // if (response.statusCode == 200) {
    //   final json = jsonDecode(response.body);
    //   return json['items']; // backenddagi responsega qarab bu o‘zgarishi mumkin
    // } else {
    //   throw Exception('Failed to fetch cart items');
    // }
  }
}
