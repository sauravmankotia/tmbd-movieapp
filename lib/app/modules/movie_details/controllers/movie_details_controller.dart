import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';

import 'package:movies_db/app/modules/home/movie_model.dart';
import 'package:movies_db/core/constants/endpoints.dart';
import 'package:movies_db/core/network/repository.dart';

import '../movie_details_model.dart';

class MovieDetailsController extends GetxController {
  List _genreList = [];
  MovieDetailModel get movieDetails => moviesDetailList.value;
  String get movieDuration => formatDuration(movieDetails.runtime!);
  List get genreList => _genreList;
  RxBool isLoading = true.obs;
  Rx<MovieDetailModel> moviesDetailList =
      Rx<MovieDetailModel>(MovieDetailModel());
  RxList<Results> movieList = <Results>[].obs;

  @override
  void onInit() {
    getInitialData();
    super.onInit();
  }

  getInitialData() async {
    await Future.wait([
      getMovieDetails(Get.arguments['movieId']),
      trendingMoviesList(),
    ]);
    isLoading(false);
  }

  Future getMovieDetails(movieId) async {
    await ApiRepository()
        .getMovieDetails(movieId)
        .then((MovieDetailModel value) {
      moviesDetailList(value);
    });
  }

  Future trendingMoviesList() async {
    await ApiRepository().trendingMoviesApiCall().then((List<Results> value) {
      movieList(value);
    });
  }

  String formatDuration(int runtime) {
    Duration duration = Duration(minutes: runtime);
    String hours = duration.inHours.toString().padLeft(0, '2');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    return "${hours}h ${minutes}m";
  }

  getGenres() {
    for (var i in movieDetails.genres!) {
      _genreList.add(i.name);
    }
  }
}
