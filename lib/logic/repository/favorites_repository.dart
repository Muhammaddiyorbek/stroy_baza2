import 'package:dio/dio.dart';
import 'package:stroy_baza/data/local/database_helper.dart';
import 'package:stroy_baza/logic/repository/auth_repository.dart';
import 'package:stroy_baza/models/product.dart';

class FavoritesRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final AuthRepository _authRepository = AuthRepository();

  Future<void> toggleFavorite(int productId) async {
    final isAuthenticated = await _authRepository.isAuthenticated();
    print("${productId} ${isAuthenticated}");

    if (isAuthenticated) {
      // Handle API favorite toggle
      final accessToken = await _authRepository.getAccessToken();
      if (!await _authRepository.isAccessTokenValid()) {
        if (!await _authRepository.isRefreshTokenValid()) {
          await _authRepository.clearAuthData();
          // Save locally if token refresh fails
          await _toggleLocalFavorite(productId);
          return;
        }
        await _authRepository
            .refreshToken(await _authRepository.getRefreshToken() ?? '');
      }

      try {
        // API call to toggle favorite
        print("uuuu");
        await _toggleApiFavorite(productId, accessToken!);
      } catch (e) {
        // Fallback to local storage if API fails
        await _toggleLocalFavorite(productId);
      }
    } else {
      // Handle local favorite toggle
      await _toggleLocalFavorite(productId);
    }
  }

  Future<void> _toggleLocalFavorite(int productId) async {
    final isFavorite = await _databaseHelper.isFavorite(productId);
    if (isFavorite) {
      await _databaseHelper.removeFavorite(productId);
    } else {
      await _databaseHelper.addFavorite(productId);
    }
  }

  Future<void> _toggleApiFavorite(int productId, String token) async {
    final dio = AuthRepository().dio;
    try {
      // Get favorites from API to check status
      final response = await dio.get(
        '/api/api/favorites/',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);

      final favorites = response.data as List;
      // Favorite obyektini topish
      final favorite = favorites.firstWhere(
        (item) => item['product'] as int == productId,
        orElse: () => null,
      );


      if (favorite != null) {
        // Remove from favorites using favorite ID
        print("delete");
        final favoriteId = favorite['id'];
        final res = await dio.delete(
          '/api/api/favorites/$favoriteId/delete/',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        print(res);
      } else {
        // Add to favorites
        print("create");
        final userId = await _authRepository.getUserId();
        final res = await dio.post(
          '/api/api/favorites/create/',
          data: {
            'product': productId,
            'user': userId,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        print(res);
      }
    } catch (e) {
      await _toggleLocalFavorite(productId);
    }
  }

  Future<List<int>> getFavoriteIds() async {
    final isAuthenticated = await _authRepository.isAuthenticated();

    if (isAuthenticated) {
      try {
        final accessToken = await _authRepository.getAccessToken();
        print(accessToken);
        final response = await AuthRepository().dio.get('/api/api/favorites/',
            options: Options(
              headers: {'Authorization': 'Bearer $accessToken'},
            ));
        print(response);
        return (response.data as List).map((e) => e['product'] as int).toList();
      } catch (e) {
        // Fallback to local favorites if API fails
        return _databaseHelper.getFavoriteIds();
      }
    }
    return _databaseHelper.getFavoriteIds();
  }

  Future<List<Product>> getProductsByIds(List<int> ids) async {
    try {
      final List<Product> products = [];
      final dio = AuthRepository().dio;

      for (final id in ids) {
        final response = await dio.get('/api/api/products/$id/');
        if (response.statusCode == 200) {
          products.add(Product.fromJson(response.data));
        }
      }

      return products;
    } catch (e) {
      return [];
    }
  }
}
