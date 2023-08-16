import 'dart:developer';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:pawder_use_case/HomeCubit.dart';
import 'package:pawder_use_case/HomeProvider.dart';
import 'package:pawder_use_case/HomeState.dart';
import 'package:pawder_use_case/userModel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  CardSwiperController controller = CardSwiperController();
  double _opacity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //context.read<HomeProvider>().addFirstData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => HomeCubit()..addFirstData(),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeCompleted) {

                if (_opacity == 0) {
                  Future.delayed(Duration(milliseconds: 250)).then((value) =>
                    setState((){
                      _opacity = 1;
                    }
                  ));
                }
              }

              if (state is HomeError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              print(state);

              if (state is HomeInitial) {
                return const Center(child: Text("Initial"),);
              }
              else if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }
              else if (state is HomeCompleted) {

                context.read<HomeCubit>().users.forEach((element) {
                  print(element.results.first.name.first);
                });


                return AnimatedOpacity(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                  opacity: _opacity,
                  child: Column(
                    children: [
                      /*Expanded(
                        child: Consumer(
                          builder: (context, myModel, child) {
                            return CardSwiper(
                              controller: controller,
                              allowedSwipeDirection: AllowedSwipeDirection.symmetric(
                                  horizontal: true,
                                  vertical: false
                              ),
                              initialIndex: 0,
                              isLoop: false,
                              numberOfCardsDisplayed: 3,
                              cardsCount: context.watch<HomeProvider>().users.length,
                              cardBuilder: (context, index, percentThresholdX, percentThresholdY) {

                                UserModel user = context.watch<HomeProvider>().users[index];

                                return Container(
                                  width: double.infinity,
                                  height: 500,
                                  color: Colors.pinkAccent.shade100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.deepOrangeAccent,
                                                  shape: BoxShape.circle
                                              ),
                                              padding: EdgeInsets.all(12),
                                              child: Text("${index + 1}")
                                          )
                                      ),
                                      Center(
                                        child: Image.network(
                                            user.results.first.picture.large,
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.fill,
                                            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                              return child;
                                            },
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              else {
                                                return Center(
                                                  child: CircularProgressIndicator(),
                                                );
                                              }
                                            }
                                        ),
                                      ),

                                      /*Center(
                                    child: CachedNetworkImage(
                                      imageUrl: user.results.first.picture.large,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.fill,
                                      fadeInCurve: Curves.linear,
                                      placeholder: (context, url) => CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                  ),*/
                                      Container(
                                        height: 200,
                                        color: Colors.black,
                                        margin: EdgeInsets.only(top: 12),
                                        child: Text(
                                          context.read<HomeProvider>().users[index].toJson().toString(),
                                          style: TextStyle(
                                              color: Colors.deepOrangeAccent,
                                              fontSize: 12
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text("List length :"),
                                      Text(context.watch<HomeProvider>().users.length.toString()),
                                    ],
                                  ),
                                );
                              },
                              onSwipe: (
                                  int previousIndex,
                                  int? currentIndex,
                                  CardSwiperDirection direction,
                                  ) async {

                                log(
                                  'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
                                );

                                await context.read<HomeProvider>().addUser(2);

                                await context.read<HomeProvider>().removeUser(context.read<HomeProvider>().users[previousIndex]);

                                return true;
                              },
                            );
                          },
                        ),
                      ),*/
                      Expanded(
                        child: CardSwiper(
                          controller: controller,
                          allowedSwipeDirection: AllowedSwipeDirection.symmetric(
                            horizontal: true,
                            vertical: false
                          ),
                          numberOfCardsDisplayed: 3,
                          initialIndex: 0,
                          isLoop: false,
                          cardsCount: context.watch<HomeCubit>().users.length,
                          cardBuilder: (context, index, percentThresholdX, percentThresholdY) {

                            UserModel user = context.watch<HomeCubit>().users[index];

                            return Container(
                              width: double.infinity,
                              height: 500,
                              color: Colors.pinkAccent.shade100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrangeAccent,
                                        shape: BoxShape.circle
                                      ),
                                      padding: EdgeInsets.all(12),
                                      child: Text("${index + 1}")
                                    )
                                  ),
                                  Center(
                                    child: Image.network(
                                      user.results.first.picture.large,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.fill,
                                      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                        return child;
                                      },
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }
                                    ),
                                  ),

                                  /*Center(
                                    child: CachedNetworkImage(
                                      imageUrl: user.results.first.picture.large,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.fill,
                                      fadeInCurve: Curves.linear,
                                      placeholder: (context, url) => CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                  ),*/
                                  Container(
                                    height: 200,
                                    color: Colors.black,
                                    margin: EdgeInsets.only(top: 12),
                                    child: Text(
                                      context.read<HomeCubit>().users[index].toJson().toString(),
                                      style: TextStyle(
                                          color: Colors.deepOrangeAccent,
                                          fontSize: 12
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text("List length :"),
                                  Text(context.watch<HomeCubit>().users.length.toString()),
                                ],
                              ),
                            );
                          },
                          onSwipe: (
                            int previousIndex,
                            int? currentIndex,
                            CardSwiperDirection direction,
                          ) async {

                            log(
                              'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
                            );

                            await context.read<HomeCubit>().addUser(2);

                            //await context.read<HomeCubit>().removeUser(context.read<HomeCubit>().users[previousIndex]);

                            return true;
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              else {
                return Center(child: Text("Error"));
              }
            },
          ),
        ),
      ),
    );
  }
}
