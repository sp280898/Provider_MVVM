import 'dart:convert';
import 'dart:io';

// import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../exception/app_exception.dart';
import 'base_api_services.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException('No Internet \n$e');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic body) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: body)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException('\nError while Communicating with serve\n$e');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        // debugPrint(responseJson.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.reasonPhrase);
      default:
        throw FetchDataException(
            'Error Occurred while Communicating with server\nStatus code:${response.statusCode}');
    }
  }
}
