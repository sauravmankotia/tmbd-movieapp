import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paginable/paginable.dart';

import 'package:movies_db/app/routes/app_pages.dart';
import 'package:movies_db/app/widgets/movie_card.dart';
import 'package:movies_db/app/widgets/shimmer_helper.dart';
import 'package:movies_db/core/constants/colors.dart';
import 'package:movies_db/core/constants/endpoints.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  String imageUrl =
      "https://d5nunyagcicgy.cloudfront.net/external_assets/hero_examples/hair_beach_v391182663/original.jpeg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Movies",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3),
                      ),
                      Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 35,
                      )
                    ],
                  )),
              Divider(
                color: Colors.transparent,
              ),
              Obx(() => !controller.isLoading.value
                  ? Expanded(
                      child: PaginableListView.separated(
                          progressIndicatorWidget: const SizedBox(
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          loadMore: () async {
                            await controller.loadMore();
                          },
                          errorIndicatorWidget: (exception, tryAgain) =>
                              Container(
                                color: Colors.redAccent,
                                height: 130,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      exception.toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                      ),
                                      onPressed: tryAgain,
                                      child: const Text('Try Again'),
                                    ),
                                  ],
                                ),
                              ),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.MOVIE_DETAILS, arguments: {
                                    'movieId': controller.movieList[index].id
                                  });
                                },
                                child: MoviesCard(
                                  movieList: controller.movieList[index],
                                ));
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Colors.transparent,
                              height: 20,
                            );
                          },
                          itemCount: controller.movieList.length),
                    )
                  : Expanded(
                      child: ShimmerHelper.buildListShimmer(
                          height: Get.height * 0.25)))
            ],
          ),
        ),
      ),
    );
  }
}
