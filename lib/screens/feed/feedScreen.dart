import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:glass_kit/glass_kit.dart';

class Feedscreen extends StatefulWidget {
  const Feedscreen({super.key});

  @override
  State<Feedscreen> createState() => _FeedscreenState();
}

class _FeedscreenState extends State<Feedscreen> {
  List<Map> cards = [
    {
      "name": "Jessica Parker",
      "age": 23,
      "tagline": "Professional model",
      "images": ["assets/demoPeople/photo (1).png"]
    },
    {
      "name": "Mary Kane",
      "age": 21,
      "tagline": "Artist",
      "images": ["assets/demoPeople/photo.png"]
    },
    {
      "name": "Jane Parker",
      "age": 25,
      "tagline": "I am Jane",
      "images": ["assets/demoPeople/photo (2).png"]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 80,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80,bottom: 30,left: 30,right: 30),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(),
                Column(
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
                SizedBox(width: 80,),

                InkWell(
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
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: CardSwiper(
                padding: EdgeInsets.zero,
                allowedSwipeDirection: AllowedSwipeDirection.symmetric(horizontal: true),
                cardsCount: cards.length,
                backCardOffset: Offset(0, -40),
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) =>
                        Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage(cards[index]['images'][0]),
                          fit: BoxFit.cover)),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GlassContainer.frostedGlass(
                      blur: 10,
                      frostedOpacity: 0.1,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      height: 90,
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                cards[index]['name'],
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                ", " + cards[index]['age'].toString(),
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          Text(
                            cards[index]['tagline'],
                            style: TextStyle(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0,
                            blurRadius: 20)
                      ],
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(child: Image.asset("assets/feed/dislike.png")),
                ),
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Color(0xffe94057),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 0,
                            blurRadius: 10)
                      ],
                      borderRadius: BorderRadius.circular(50)),
                  child:
                      Center(child: Image.asset("assets/feed/superLike.png")),
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0,
                            blurRadius: 20)
                      ],
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(child: Image.asset("assets/feed/like.png")),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
