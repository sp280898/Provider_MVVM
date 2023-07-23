// import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/movie_model.dart';

import '../repository/home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<MoviesModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MoviesModel> response) {
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchMoviesList() async {
    setMoviesList(ApiResponse.loading());
    _myRepo.fetchMoviesList().then((value) {
      setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
      throw error.toString();
    });
  }
}
