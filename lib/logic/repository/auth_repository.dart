import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stroy_baza/app_constats/app_url.dart';
import 'package:stroy_baza/models/auth_model.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();

  factory AuthRepository() => _instance;

  late final Dio dio;
  SharedPreferences? _prefs;

  AuthRepository._internal() {
    dio = Dio(BaseOptions(
      baseUrl: AppUrl.base,
      validateStatus: (status) => status! < 500,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Accept': 'application/json'},
    ));
  }

  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<Map<String, dynamic>> sendPhoneNumber(String phoneNumber, bool isLogin) async {
    try {
      final endpoint = isLogin ? '/api/api/login/phone/' : '/api/api/register/';
      final response = await dio.post(
        endpoint,
        data: {"phone_number": phoneNumber, "source": "mobile"},
      );

      if (response.statusCode == 400) {
        return {'success': false, 'message': response.data['error'] ?? 'User already exists'};
      }

      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      return {'success': false, 'message': e.response?.data['error'] ?? 'Something went wrong'};
    }
  }

  Future<Map<String, dynamic>> verifyPhone(String phoneNumber, String code, bool isLogin) async {
    try {
      final endpoint = isLogin ? '/api/api/login/phone/verify/' : '/api/api/verify/';
      final response = await dio.post(
        endpoint,
        data: {'phone_number': phoneNumber, 'verification_code': code},
      );
      print("63 ${response.data} ${response}");
      if (response.data == null) {
        return {'success': false, 'message': 'Invalid server response'};
      }

      if (response.data['access'] == null || response.data['refresh'] == null) {
        return {'success': false, 'message': '.'}; //Invalid token response'
      }

      final authModel = AuthModel(
        phoneNumber: phoneNumber,
        accessToken: response.data['access'] as String?,
        refreshToken: response.data['refresh'] as String?,
        userId: response.data['id'] as int?,
      );
      print("${authModel} 8 ${authModel.accessToken}");
      await _saveAuthData(authModel);

      return {'success': true, 'data': authModel, 'message': response.data['message'] ?? 'Verification successful'};
    } on DioException catch (e) {
      return {'success': false, 'message': e.response?.data['message'] ?? 'Verification failed'};
    }
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      // Check access token validity
      if (!await isAccessTokenValid()) {
        // Access token expired, check refresh token
        if (!await isRefreshTokenValid()) {
          // Refresh token expired, logout user
          await clearAuthData();
          return {'success': false, 'message': 'Session expired. Please login again'};
        }

        // Try to refresh access token
        final refreshResult = await refreshToken(await getRefreshToken() ?? '');
        if (!refreshResult['success']) {
          await clearAuthData();
          return {'success': false, 'message': 'Failed to refresh token'};
        }
      }

      // Continue with user info request
      final preferences = await prefs;
      final userId = preferences.getInt('user_id');
      final accessToken = await getAccessToken();

      final response = await dio.get(
        '/api/api/users/$userId/',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      final user = UserModel.fromJson(response.data);
      await _saveUserData(user);
      return {'success': true, 'data': user};
    } catch (e) {
      return {'success': false, 'message': 'Failed to get user info'};
    }
  }

  Future<Map<String, dynamic>> updateUserProfile({
    required String firstName,
    required String lastName,
  }) async {
    try {
      // Check access token validity
      if (!await isAccessTokenValid()) {
        if (!await isRefreshTokenValid()) {
          await clearAuthData();
          return {'success': false, 'message': 'Session expired. Please login again'};
        }

        final refreshResult = await refreshToken(await getRefreshToken() ?? '');
        if (!refreshResult['success']) {
          await clearAuthData();
          return {'success': false, 'message': 'Failed to refresh token'};
        }
      }

      final preferences = await prefs;
      final userId = preferences.getInt('user_id');
      final accessToken = await getAccessToken();

      if (userId == null) {
        return {'success': false, 'message': '...'};
      }

      final response = await dio.put(
        '/api/api/users/$userId/update/',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
        data: {
          'first_name': firstName,
          'last_name': lastName,
        },
      );

      if (response.statusCode == 200) {
        await _saveUserData(UserModel(
          id: userId,
          username: preferences.getString('username') ?? '',
          phoneNumber: preferences.getString('phone') ?? '',
          firstName: firstName,
          lastName: lastName,
        ));
        return {'success': true};
      } else {
        return {'success': false, 'message': response.data['message'] ?? 'Profile update failed'};
      }
    } on DioException catch (e) {
      return {'success': false, 'message': e.response?.data['message'] ?? 'Something went wrong'};
    }
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(
        '/api/api/token/refresh/',
        data: {'refresh': refreshToken},
      );

      final newAccessToken = response.data['access'];
      final preferences = await prefs;
      await preferences.setString('access_token', newAccessToken);
      return {'success': true, 'data': newAccessToken};
    } on DioException catch (e) {
      return {'success': false, 'message': e.response?.data['message'] ?? 'Token refresh failed'};
    }
  }

  Future<void> _saveAuthData(AuthModel auth) async {
    final preferences = await prefs;
    await preferences.setString('phone', auth.phoneNumber);
    await preferences.setString('access_token', auth.accessToken ?? '');
    await preferences.setString('refresh_token', auth.refreshToken ?? '');
    if (auth.userId != null) {
      await preferences.setInt('user_id', auth.userId!);
    }
    if (auth.user != null) {
      await _saveUserData(auth.user!);
    }
  }

  Future<void> _saveUserData(UserModel user) async {
    final preferences = await prefs;
    await preferences.setInt('user_id', user.id);
    await preferences.setString('username', user.username);
    await preferences.setString('first_name', user.firstName ?? '');
    await preferences.setString('last_name', user.lastName ?? '');
  }

  Future<void> clearAuthData() async {
    final preferences = await prefs;
    await preferences.clear();
  }

  Future<bool> isAuthenticated() async {
    final preferences = await prefs;
    return preferences.getString('access_token') != null;
  }

  Future<UserModel?> getCurrentUser() async {
    final preferences = await prefs;
    final id = preferences.getInt('user_id');
    if (id == null) return null;

    return UserModel(
      id: id,
      username: preferences.getString('username') ?? '',
      phoneNumber: preferences.getString('phone') ?? '',
      firstName: preferences.getString('first_name'),
      lastName: preferences.getString('last_name'),
    );
  }

  Future<String?> getAccessToken() async {
    try {
      final preferences = await prefs;
      final accessToken = preferences.getString('access_token');
      if (accessToken == null) return null;

      final decodedToken = JwtDecoder.decode(accessToken);
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);

      if (DateTime.now().isBefore(expiryDate)) {
        return accessToken;
      }

      // Access token expired, try to refresh
      final refreshResult = await refreshToken(await getRefreshToken() ?? '');
      if (refreshResult['success']) {
        return preferences.getString('access_token'); // Get new access token from storage
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      final preferences = await prefs;
      final refreshToken = preferences.getString('refresh_token');
      if (refreshToken == null) return null;

      final decodedToken = JwtDecoder.decode(refreshToken);
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);

      if (DateTime.now().isBefore(expiryDate)) {
        return refreshToken;
      }

      // Refresh token expired, logout user
      await clearAuthData();
      return null;
    } catch (e) {
      await clearAuthData();
      return null;
    }
  }

  Future<String?> getPhoneNumber() async {
    final preferences = await prefs;
    return preferences.getString('phone');
  }

  Future<int?> getUserId() async {
    final preferences = await prefs;
    return preferences.getInt('user_id');
  }

  Future<bool> isAccessTokenValid() async {
    try {
      final accessToken = await getAccessToken();
      if (accessToken == null) return false;

      final decodedToken = JwtDecoder.decode(accessToken);
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
      final currentDate = DateTime.now();

      return currentDate.isBefore(expiryDate);
    } catch (e) {
      return false;
    }
  }

  Future<bool> isRefreshTokenValid() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) return false;

      final decodedToken = JwtDecoder.decode(refreshToken);
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
      final currentDate = DateTime.now();

      return currentDate.isBefore(expiryDate);
    } catch (e) {
      return false;
    }
  }
}
