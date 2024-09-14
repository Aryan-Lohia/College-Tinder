import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:glass_kit/glass_kit.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
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
    },{
      "name": "Emily Cyrus",
      "age": 25,
      "tagline": "I am Jane",
      "images": ["assets/demoPeople/photo (8).png"]
    },{
      "name": "Taylor Jane",
      "age": 25,
      "tagline": "I am Jane",
      "images": ["assets/demoPeople/photo (10).png"]
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
            padding: EdgeInsets.only(top: 120,bottom: 30,left: 30,right: 30),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Matches",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      InkWell(
                        child: Image.asset("assets/matches/sort.png"),
                      )
                    ],

                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "This is a list of people who have liked you\nand your matches.",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Flexible(child: Divider(thickness: 0.3,color: Colors.black,height: 1,)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Today",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                ),
                Flexible(child: Divider(thickness: 0.3,color: Colors.black,height: 1,)),

              ],

            ),
          ),
          Flexible(child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: cards.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.75), itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(15),
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: AssetImage(cards[index]['images'][0]),
                      fit: BoxFit.cover)),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            cards[index]['name'].split(' ')[0],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            ", " + cards[index]['age'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    GlassContainer.frostedGlass(
                      blur: 10,
                      frostedOpacity: 0.1,
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      height: 50,
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Center(child: Image.asset('assets/matches/dislike.png',height: 20,width: 20,)),
                          VerticalDivider(color: Colors.white,),
                          Center(child: Image.asset('assets/feed/superLike.png',height: 20,width: 20,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },))
        ],
      ),
    );
  }
}
