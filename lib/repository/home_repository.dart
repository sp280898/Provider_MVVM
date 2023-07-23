import 'package:mvvm/data/exception/app_exception.dart';
import 'package:mvvm/data/network/base_api_services.dart';
import 'package:mvvm/res/app_urls.dart';

import '../data/network/network_api_sevices.dart';
import '../model/movie_model.dart';

class HomeRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<MoviesModel> fetchMoviesList() async {
    try {
      dynamic response =
          await _apiService.getGetApiResponse(MovieUrl.movieListEndpoint);
      return response = MoviesModel.fromJson(response);
    } catch (e) {
      throw FetchDataException('\nNo Internet');
    }
  }
}
