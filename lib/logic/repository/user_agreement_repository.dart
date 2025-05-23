import 'package:dio/dio.dart';
import 'package:stroy_baza/models/user_agreement_model.dart';

class UserAgreementRepository {
  final Dio dio;

  UserAgreementRepository(this.dio);

  Future<UserAgreementModel> fetchAgreement(String locale) async {
    final response = await dio.get('https://back.stroybazan1.uz/api/api/user-agreements/');
    final data = response.data;
    if (data is List && data.isNotEmpty) {
      return UserAgreementModel.fromJson(data[0], locale);
    } else {
      throw Exception("User agreement not found");
    }
  }
}
