

import 'package:dio/dio.dart';

import 'package:movies_db/app/modules/home/genre_model.dart';
import 'package:movies_db/app/modules/home/movie_model.dart';
import 'package:movies_db/app/modules/movie_details/movie_details_model.dart';
import 'package:movies_db/core/network/dio_client.dart';

import '../constants/endpoints.dart';

class ApiRepository {
  DioClient dioClient = DioClient();

  Future<MovieDetailModel> getMovieDetails(movieId) async {
    MovieDetailModel movieDetailModel = MovieDetailModel();
    Response response =
        await dioClient.get(ApiEndpoints.movieDetailsUrl(movieId));
    if (response.statusCode == 200) {
      movieDetailModel = MovieDetailModel.fromJson(response.data);
    }
    return movieDetailModel;
  }

  Future<List<Results>> trendingMoviesApiCall() async {
    List<Results> resultsList = [];
    Response response = await dioClient.get(ApiEndpoints.upcomingMoviesUrl(1));
    if (response.statusCode == 200) {
      resultsList = MovieItemModel.fromJson(response.data).results!;
    }
    return resultsList;
  }

  Future<List<Genres>> genreDataApiCall() async {
    List<Genres> genreDataList = [];
    Response response = await dioClient.get(ApiEndpoints.genresUrl());
    if (response.statusCode == 200) {
      genreDataList = GenreModel.fromJson(response.data).genres!;
    }
    return genreDataList;
  }

  Future<List<Results>> topMoviesApiCall({int pageCount = 1}) async {
    List<Results> topMoviesList = [];
    Response response =
        await dioClient.get(ApiEndpoints.topRatedUrl(page: pageCount));
    if (response.statusCode == 200) {
      topMoviesList = MovieItemModel.fromJson(response.data).results!;
    }
    return topMoviesList;
  }
}
