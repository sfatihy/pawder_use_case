import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:pawder_use_case/ListCubit.dart';
import 'package:pawder_use_case/userModel.dart';
import 'package:provider/provider.dart';

class ListCardView extends StatefulWidget {
  const ListCardView({Key? key}) : super(key: key);

  @override
  State<ListCardView> createState() => _ListCardViewState();
}

class _ListCardViewState extends State<ListCardView> {

  CardSwiperController controller = CardSwiperController();
  double _opacity = 0;

  int indexOfProfiles = 0;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ListCubit()..addUser(5),
          child: BlocConsumer<ListCubit, List<UserModel>>(
            listener: (context, state) {
              if (state.length >= 5) {

                if (_opacity == 0) {
                  Future.delayed(Duration(milliseconds: 250)).then((value) =>
                    setState((){
                      _opacity = 1;
                    })
                  );
                }
              }

            },
            builder: (context, state) {

              if (state.length == 0) {
                return const Center(child: CircularProgressIndicator());
                return const Center(child: Text("Initial"),);
              }
              else if (state.length == 1) {
                return const Center(child: CircularProgressIndicator());
              }
              else if (state.length >= 5) {

                /*state.forEach((element) {
                  print(element.results.first.name.first);
                });*/

                return AnimatedOpacity(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                  opacity: _opacity,
                  child: Column(
                    children: [
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
                          cardsCount: state.length,
                          cardBuilder: (context, index, percentThresholdX, percentThresholdY) {

                            UserModel user = state[index];

                            return Container(
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
                                          child: Text("${indexOfProfiles + 1}")
                                      )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
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
                                    color: Colors.white,
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    padding: EdgeInsets.only(left: 8),
                                    height: MediaQuery.of(context).size.height * 0.15,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Name: ${user.results.first.name.title} ${user.results.first.name.first} ${user.results.first.name.last}"),
                                        Text("E mail: ${user.results.first.email}"),
                                        Text("Address: ${user.results.first.location.street.number} ${user.results.first.location.street.name} ${user.results.first.location.city} ${user.results.first.location.state} ${user.results.first.location.country} ${user.results.first.location.postcode}"),
                                      ],
                                    ),
                                  ),
                                  /*Container(
                                    height: 200,
                                    color: Colors.black,
                                    margin: EdgeInsets.only(top: 12),
                                    child: Text(
                                      state[index].toJson().toString(),
                                      style: TextStyle(
                                          color: Colors.deepOrangeAccent,
                                          fontSize: 12
                                      ),
                                    ),
                                  ),*/

                                  Center(
                                    child: ElevatedButton(
                                      child: Text("Message"),
                                      onPressed: () {
                                        log("Message to ${user.results.first.name.first}");
                                      },
                                    ),
                                  ),

                                  Spacer(),
                                  Text("List length :"),
                                  Text(state.length.toString()),
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
                              'The card ${state[previousIndex].results.first.name.first} was swiped to the ${direction.name}. Now the card ${state[currentIndex!].results.first.name.first} is on top',
                            );

                            await context.read<ListCubit>().addUser(2);

                            context.read<ListCubit>().removeUser(state[previousIndex]);

                            setState(() {
                              indexOfProfiles++ ;
                            });

                            return false;
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
