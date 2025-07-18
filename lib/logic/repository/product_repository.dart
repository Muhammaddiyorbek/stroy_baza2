import 'dart:developer';

import 'package:stroy_baza/core/services/local_storage_helper.dart';
import 'package:stroy_baza/core/services/network_service/api.dart';
import 'package:stroy_baza/core/services/network_service/api_const.dart';
import 'package:stroy_baza/models/banner_model.dart';
import 'package:stroy_baza/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProduct({required int branch});

  Future<List<BannerModel>> getBanner();

  Future<Product?> getSingleProduct({required String id});

  Future<bool> addBasket({required Product product});
}

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<List<Product>> getProduct({required int branch}) async {
    List<Product> products = [];
    final res = await ApiService.get(ApiConst.apiProduct, ApiParams.productBranchParam(branch));
    if (res != null && res.isNotEmpty) {
      products = productsFromJson(res);
      return products;
    } else {
      return [];
    }
  }

  @override
  Future<List<BannerModel>> getBanner() async {
    List<BannerModel> banners = [];
    final res = await ApiService.get(ApiConst.apiBanner, ApiParams.emptyParams());
    if (res != null && res.isNotEmpty) {
      banners = bannerModelFromJson(res);
      return banners;
    } else {
      return [];
    }
  }

  @override
  Future<Product?> getSingleProduct({required String id}) async {
    final Product product;
    final res = await ApiService.get("${ApiConst.apiSingleProduct}$id/", ApiParams.emptyParams());
    if (res != null && res.isNotEmpty) {
      product = singleProductFromJson(res);
      log("${product.descriptionUz} -- ${product.image} -- ${product.id} -- ${product.isAvailable}");
      log("${product.variants.length}");
      return product;
    } else {
      return null;
    }
  }

  @override
  Future<bool> addBasket({required Product product}) async {
    final map = <String, dynamic>{
      "product_variant_id": product.id,
      "quantity": 2,
      "price": "11 200",
      "order": "vbnm",
      "product_variant": "vhgjkl",
    };
    final token = StorageRepository.getString("token", defValue: '');
    final header = <String, String>{"Authorization": "Bearer $token"};

    log("Header $header");
    final result = await ApiService.post(
      ApiConst.apiOrderCreate,
      map,
      header: header,
    );
    log("result data: $result");
    if (result != null && result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
