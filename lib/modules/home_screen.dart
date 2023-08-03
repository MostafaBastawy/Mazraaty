import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/cubits/home_cubit/home_cubit.dart';
import 'package:mazraaty/cubits/home_cubit/home_states.dart';
import 'package:mazraaty/modules/places_by_category_screen.dart';
import 'package:mazraaty/modules/search_screen.dart';
import 'package:mazraaty/networks/local/cache_helper.dart';
import 'package:mazraaty/shared/components.dart';
import 'package:mazraaty/shared/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final slideshowCtrl = PageController();
  Timer? slideshowTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    startSlideshowTimer();
    HomeCubit.get(context).getHome();
    HomeCubit.get(context).getSliders();
    HomeCubit.get(context).getMostBooked();
    super.initState();
  }

  void startSlideshowTimer() {
    if (slideshowTimer != null && slideshowTimer!.isActive) {
      slideshowTimer!.cancel();
    }
    slideshowTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (slideshowCtrl.hasClients) {
        final double? currentPage = slideshowCtrl.page;
        _currentIndex = currentPage?.toInt() ?? 0;
        final slideshow = HomeCubit.get(context).slides;
        if (currentPage != null && currentPage < (slideshow.length - 1)) {
          if (mounted) {
            setState(() => _currentIndex++);
          }
          slideshowCtrl.animateToPage(_currentIndex,
              duration: const Duration(milliseconds: 1000), curve: Curves.ease);
        } else if (currentPage != null &&
            currentPage == (slideshow.length - 1)) {
          if (mounted) {
            setState(() => _currentIndex = 0);
          }
          slideshowCtrl.animateToPage(_currentIndex,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOut);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final token = CacheHelper.getData("userToken");
    return Scaffold(
        appBar: customAppbar(context: context, title: "mazraaty".tr()),
        body: BlocBuilder<HomeCubit, HomeStates>(
          builder: (context, state) {
            if (HomeCubit.get(context).homeModel != null) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (token != null)
                        Row(
                          children: [
                            // Card(
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(5),
                            //     child: Image.asset("assets/images/menu.png"),
                            //   ),
                            // ),
                            // SizedBox(width: 5,),
                            Expanded(
                                child: Text(
                                    "${"welcome".tr()} , ${CacheHelper.getData("userName")} ${"welcomeToMazraatyApp".tr()}")),
                            Image.asset("assets/images/bye.png")
                          ],
                        ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          navigateTo(context: context, page: SearchScreen());
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: kAppColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "searchAndSelectABookingTime".tr(),
                                style: TextStyle(color: Colors.white),
                              ),
                              Image.asset("assets/images/calender.png")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (HomeCubit.get(context).slides.isNotEmpty)
                        buildSlideshowView(),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: List.generate(
                                HomeCubit.get(context)
                                    .homeModel!
                                    .data!
                                    .categories!
                                    .length, (index) {
                              return InkWell(
                                onTap: () {
                                  navigateTo(
                                      context: context,
                                      page: PlacesByCategoryScreen(
                                          categoryId: HomeCubit.get(context)
                                              .homeModel!
                                              .data!
                                              .categories![index]
                                              .id,
                                          categoryName: HomeCubit.get(context)
                                              .homeModel!
                                              .data!
                                              .categories![index]
                                              .name));
                                },
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      HomeCubit.get(context)
                                                          .homeModel!
                                                          .data!
                                                          .categories![index]
                                                          .image!)))),
                                    ),
                                    Text(HomeCubit.get(context)
                                        .homeModel!
                                        .data!
                                        .categories![index]
                                        .name!)
                                  ],
                                ),
                              );
                            }),
                          ),
                          if (HomeCubit.get(context).mostBooked.isNotEmpty) ...[
                            Text("mostBooked".tr()),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return buildProductItem(context,
                                      HomeCubit.get(context).mostBooked[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount:
                                    HomeCubit.get(context).mostBooked.length)
                          ],
                          SizedBox(
                            height: 20,
                          ),
                          Text("latestAdditions".tr(),),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return buildProductItem(
                                    context,
                                    HomeCubit.get(context)
                                        .homeModel!
                                        .data!
                                        .places![index]);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: HomeCubit.get(context)
                                  .homeModel!
                                  .data!
                                  .places!
                                  .length)
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else {
              return customCircleProgressIndicator();
            }
          },
        ));
  }

  Container buildSlidesImageView(
    BuildContext context, {
    required String imageUrl,
    required int index,
  }) {
    // final isArabic = lang == "ar";
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: 160,
        width: double.infinity,
        color: Colors.black12,
        colorBlendMode: BlendMode.darken,
        fit: BoxFit.cover,
        errorWidget: (context, error, stackTrace) => LoadingImageContainer(
          height: 160,
          width: double.infinity,
        ),
        placeholder: (context, url) => LoadingImageContainer(
          height: 160,
          width: double.infinity,
          repeat: false,
        ),
      ),
    );
  }

  Widget buildSlideshowView() {
    return Column(
      children: [
        Container(
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: slideshowCtrl,
            itemCount: HomeCubit.get(context).slides.length,
            itemBuilder: (context, index) {
              final slideshow = HomeCubit.get(context).slides[index];
              return buildSlidesImageView(
                context,
                imageUrl: slideshow.image,
                index: index,
              );
            },
            onPageChanged: (value) {
              if (mounted) {
                setState(() => _currentIndex = value);
              }
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
