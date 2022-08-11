import 'package:get/get.dart';

import 'package:movies_db/app/modules/home/genre_model.dart';
import 'package:movies_db/app/modules/home/movie_model.dart';
import 'package:movies_db/core/network/repository.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find<HomeController>();
  RxBool isLoading = true.obs;
  RxList<Results> movieList = <Results>[].obs;
  RxList<Genres> genreList = <Genres>[].obs;
  int pageCount = 1;

  @override
  void onInit() {
    getInitialData();
    super.onInit();
  }

  Future<void> getInitialData() async {
    await Future.wait([getMoviesData(), getGenreData()]);
    isLoading(false);
  }

  Future getMoviesData() async {
    await ApiRepository().topMoviesApiCall().then((value) => movieList(value));
  }

  Future<void> loadMore() async {
    pageCount++;
    await ApiRepository()
        .topMoviesApiCall(pageCount: pageCount)
        .then((value) => movieList.addAll(value));
  }

  Future getGenreData() async {
    await ApiRepository().genreDataApiCall().then((value) => genreList(value));
  }

  List<String> getGenreName(List<int> genreIndexList) {
    List<String> titleList = [];
    for (int genreIndex in genreIndexList) {
      for (var element in genreList) {
        if (element.id == genreIndex) {
          titleList.add(element.name!);
        }
      }
    }
    return titleList;
  }
}
