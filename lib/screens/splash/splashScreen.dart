import 'package:college_tinder/common/components/buttonDesign.dart';
import 'package:college_tinder/screens/login/loginScreen.dart';
import 'package:college_tinder/screens/login/signupScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    int _current = 0;
    CarouselSliderController carouselController = CarouselSliderController();
    const List<Map<String, String>> onboardingCarousel = [
      {
        "title": "Algorithm",
        "image": 'assets/carousel/girl1.png',
        "desc":
            "Users going through a vetting process \nto ensure you never match with bots."
      },
      {
        "title": "Matches",
        "image": 'assets/carousel/girl2.png',
        "desc":
            "We match you with people that have \na large array of similar interests."
      },
      {
        "title": "Premium",
        "image": 'assets/carousel/girl3.png',
        "desc":
            "Sign up today and enjoy the first month \nof premium benefits on us."
      }
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          children: [
            CarouselSlider.builder(
                carouselController: carouselController,
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 1.65,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.7,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                itemCount: onboardingCarousel.length,
                itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) =>
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 2.4,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage(
                                    onboardingCarousel[itemIndex]['image']!),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          onboardingCarousel[itemIndex]['title']!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color(0xffe94057)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Text(
                              onboardingCarousel[itemIndex]['desc']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: onboardingCarousel.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(vertical: .0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Color(0xffe94057))
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding:       const EdgeInsets.fromLTRB(30.0,40,30,30),

              child: InkWell(
                onTap: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>const SignupScreen()));
                },
                child: MainButtonDesign(text: "Create an Account"),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.black),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>const LoginScreen()));

                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xffe94057)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
