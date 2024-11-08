import 'dart:convert';

import 'package:college_tinder/common/global.dart';
import 'package:college_tinder/models/UserModel.dart';
import 'package:college_tinder/screens/common/loadingScreen.dart';
import 'package:college_tinder/screens/feed/homeAPI.dart';
import 'package:college_tinder/screens/matches/itsAMatch.dart';
import 'package:college_tinder/screens/profile/profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:provider/provider.dart';

import '../login/backend.dart';
import '../settings/accountSettings.dart';
import '../settings/helpAndSupport.dart';
import 'filterBottomSheet.dart';

class Feedscreen extends StatefulWidget {
  const Feedscreen({super.key});

  @override
  State<Feedscreen> createState() => _FeedscreenState();
}

class _FeedscreenState extends State<Feedscreen> {
  HomeController controller = HomeController();

  CardSwiperController swiperController = CardSwiperController();
  Map<String, dynamic> filters = {
    "interestedIn": 0,
    "distance": 0,
    "ageRange": 0,
    "location": 0,
  };
  bool isLoading = true;
  List cards = [];

  void _openFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      builder: (context) {
        return FilterBottomSheet(
          onApplyFilters: (filters) {
            // Handle filter API call here
            print("Filters applied: $filters");
            setFilters(filters);
            // Call your feed update API or update logic here
          },
        );
      },
    );
  }

  void fetchData(Map<String, dynamic> newFilters) async {
    final authProvider = Provider.of<Authentication>(context, listen: false);
    var data =
    await controller.getUsersList(authProvider.userProfile!.id!, filters);
    if (data != null) {
      cards = data['users'] as List;
    } else {
      cards = [];
    }
    setState(() {
      isLoading = false;
    });
  }

  void setFilters(Map<String, dynamic> newFilters) {
    filters['interestedIn'] = newFilters['interestedIn'];
    filters['distance'] = newFilters['distance'];
    filters['ageRange'] = newFilters['ageRange'];
    filters['location'] = newFilters['location'];
    fetchData(filters);
  }

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<Authentication>(context, listen: false);
    setFilters({
      "interestedIn": authProvider.userProfile!.interestedIn,
      "distance": 10,
      "ageRange": const RangeValues(18, 27),
      "location": "Chicago, USA",
    });
  }

  void _openMenu(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Authentication>(context, listen: false);
    return Scaffold(
      key: _key, // Assign the key to Scaffold.
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title:             Column(
                children: [
                  Image.asset("assets/logo.png"),
                  const Text(
                    "College Hearts",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            ListTile(
              title: const Text('Account Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => AccountSettings(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Help and Support'),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => HelpAndSupport(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () async {
                FirebaseAuth _auth = FirebaseAuth.instance;
                await _auth.signOut();
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? const LoadingScreen()
          : cards.isEmpty
          ? const Center(
        child: Text(
          "We are finding more matches for you!",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.grey),
        ),
      )
          : SizedBox(
        height: MediaQuery.of(context).size.height - 80,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 80, bottom: 30, left: 30, right: 30),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => _key.currentState!.openDrawer(), // <-- Opens drawer
                      icon: const Icon(Icons.menu),
                    ),
                    const Spacer(),
                    const Column(
                      children: [
                        Text(
                          "Discover",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "Chicago, 11",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    InkWell(
                      onTap: () {
                        _openFilterBottomSheet(context);
                      },
                      child: Image.asset("assets/feed/filter.png"),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: CardSwiper(
                  controller: swiperController,
                  padding: EdgeInsets.zero,
                  onSwipe: (int index, _,
                      CardSwiperDirection direction) async {
                    if (direction == CardSwiperDirection.right) {
                      bool? match = await controller.swipe(
                          authProvider.userProfile!.id!,
                          cards[index]['id'],
                          swiperAction.like);
                      if (match != null && match) {
                        //showPOPUP
                        await Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ItsAMatch(
                                  matchData: UserModel.fromJson(
                                      cards[index]),
                                )));
                      }
                    } else {
                      bool? match = await controller.swipe(
                          authProvider.userProfile!.id!,
                          cards[index]['id'],
                          swiperAction.dislike);
                    }
                    return true;
                  },
                  allowedSwipeDirection: const AllowedSwipeDirection
                      .symmetric(horizontal: true),
                  cardsCount: cards.length,
                  numberOfCardsDisplayed: cards.length,
                  backCardOffset: const Offset(0, -40),
                  cardBuilder: (context, index, percentThresholdX,
                      percentThresholdY) =>
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => ProfileScreen(
                                      userData: UserModel.fromJson(
                                          cards[index]))));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height:
                          MediaQuery.of(context).size.height * 0.7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(cards[index]
                                  ['profile_pic_url'] ??
                                      "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg"),
                                  fit: BoxFit.cover)),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GlassContainer.frostedGlass(
                              blur: 10,
                              frostedOpacity: 0.1,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              height: 90,
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        (cards[index]['first_name'] ?? "") +
                                            " " +
                                            (cards[index]['last_name'] ??
                                                ""),
                                        style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      cards[index]['dob'] != null
                                          ? Text(
                                        ", ${calculateAge(DateTime.parse(cards[index]['dob']))}",
                                        style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight:
                                            FontWeight.bold,
                                            color: Colors.white),
                                      )
                                          : Container()
                                    ],
                                  ),
                                  Text(
                                    cards[index]['bio'] ?? "",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () {
                      swiperController
                          .swipe(CardSwiperDirection.left);
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            const BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0,
                                blurRadius: 20)
                          ],
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                          child:
                          Image.asset("assets/feed/dislike.png")),
                    ),
                  ),
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        color: const Color(0xffe94057),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 0,
                              blurRadius: 10)
                        ],
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child:
                        Image.asset("assets/feed/superLike.png")),
                  ),
                  InkWell(
                    onTap: () {
                      swiperController
                          .swipe(CardSwiperDirection.right);
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            const BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0,
                                blurRadius: 20)
                          ],
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                          child: Image.asset("assets/feed/like.png")),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}