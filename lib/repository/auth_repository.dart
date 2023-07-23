import 'package:mvvm/data/network/network_api_sevices.dart';
import 'package:mvvm/res/app_urls.dart';

import '../data/network/base_api_services.dart';

class AuthRepository {
  final BaseApiService _apiService = NetworkApiService();
  Future<dynamic> loginApi(dynamic body) async {
    try {
      dynamic response =
          await _apiService.getPostApiResponse(AppUrl.loginEndPoint, body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signUpApi(dynamic body) async {
    try {
      dynamic response =
          await _apiService.getPostApiResponse(AppUrl.signUpEndPoint, body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
