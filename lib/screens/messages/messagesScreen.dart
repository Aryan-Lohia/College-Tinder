import 'package:flutter/material.dart';

class Messagesscreen extends StatefulWidget {
  const Messagesscreen({super.key});

  @override
  State<Messagesscreen> createState() => _MessagesscreenState();
}

class _MessagesscreenState extends State<Messagesscreen> {
  final List<String> imageUrls = [
    'assets/demoPeople/jessica/photo main.png',  // Replace with your image URLs
    'assets/demoPeople/photo (1).png',  // Replace with your image URLs
    'assets/demoPeople/photo (3).png',  // Replace with your image URLs
    'assets/demoPeople/photo (2).png',  // Replace with your image URLs
    'assets/demoPeople/photo (4).png',  // Replace with your image URLs
    'assets/demoPeople/photo (6).png',  // Replace with your image URLs
    'assets/demoPeople/photo (5).png',  // Replace with your image URLs
    'assets/demoPeople/photo (8).png',  // Replace with your image URLs
   // Replace with your image URLs
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
    body: Column(

      children: [
        Padding(
          padding: EdgeInsets.only(top: 120,bottom: 30,left: 30,right: 30),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Messages",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    InkWell(
                      child: Image.asset("assets/feed/filter.png"),
                    )
                  ],

                ),
                SizedBox(height: 15,),
                Align(
                  alignment: Alignment.centerLeft,
                  child:             Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(20)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(20)),
                          labelText: "Search",
                          icon: Icon(Icons.search,),
                          labelStyle: TextStyle(color: Colors.black.withOpacity(0.3))),
                    ),
                  ),

                ),

              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Activities",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(

                    scrollDirection: Axis.horizontal,
                    itemCount: imageUrls.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xffe94057),
                          child: CircleAvatar(radius: 28,
                            backgroundImage: AssetImage(imageUrls[index]),),
                        ),
                      );
                    }),
              ),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Messages",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: imageUrls.length,
              itemBuilder: (context,index){
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xffe94057),
                        child: CircleAvatar(radius: 28,
                        backgroundImage: AssetImage(imageUrls[index]),),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jessica",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),Text(
                            "Jessica",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            "12 min",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Colors.black),
                          ),
                          SizedBox(height: 5,),
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Color(0xffe94057),
                            child: Text("1",style: TextStyle(color: Colors.white,fontSize: 10),),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Divider(),
                ),
              ],
            );
          }),
        ),
      ],
    ),
    );
  }
}
