import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/demoPeople/jessica/photo main.png',  // Replace with your image URLs
    'assets/demoPeople/jessica/photo-1.png',  // Replace with your image URLs
    'assets/demoPeople/jessica/photo-2.png',  // Replace with your image URLs
    'assets/demoPeople/jessica/photo-3.png',  // Replace with your image URLs
    'assets/demoPeople/jessica/photo-4.png',  // Replace with your image URLs
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height-80,

      child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height * 0.6,
          collapsedHeight: 300,
          flexibleSpace: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/demoPeople/photo (2).png'), // Replace with your image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(

        child:        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Colors.orange, size: 30),
                  ),
                  SizedBox(width: 30),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xffe94057),
                    child: Icon(Icons.favorite, color: Colors.white, size: 40),
                  ),
                  SizedBox(width: 30),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.star, color: Colors.purple, size: 30),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jessica, 23',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text('Professional model',
                          style: TextStyle(fontSize:14,color: Colors.black)),
                    ],
                  ),
                  InkWell(
                    onTap: (){},
                    child: Image.asset('assets/send.png'),
                  )
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5,),
                      Text('Chicago, IL United States'),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xffe94057).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                                          child: Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.pinkAccent),
                        SizedBox(width: 5),
                        Text('1 km',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                'About',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'My name is Jessica Parker and I enjoy meeting new people and finding ways to help them have an uplifting experience. I enjoy reading..',

              ),
              SizedBox(height: 5),
              InkWell(
                onTap: () {},
                child: Text(
                  'Read more',
                  style: TextStyle(
                    fontSize: 12,
                      color: Color(0xffe94057), fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Interests',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildInterestChip('Travelling'),
                  _buildInterestChip('Books'),
                  _buildInterestChip('Music', isSelected: false),
                  _buildInterestChip('Dancing', isSelected: false),
                  _buildInterestChip('Modeling', isSelected: false),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gallery',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to another screen or action
                        },
                        child: Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffe94057),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // First Row with 2 images
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            imageUrls[0],
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            imageUrls[1],
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Second Row with 3 images
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            imageUrls[2],
                            fit: BoxFit.cover,
                            height: 130,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            imageUrls[3],
                            fit: BoxFit.cover,
                            height: 130,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            imageUrls[4],
                            fit: BoxFit.cover,
                            height: 130,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )


          ),

      ]),


    );
  }

  Widget _buildInterestChip(String label, {bool isSelected = true}) {
    return Chip(
      avatar: isSelected?Icon(Icons.check,color: Color(0xffe94057),):null,
      labelPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      backgroundColor: isSelected ? Color(0xfff7c5cc) : Colors.grey[200],
      shape: StadiumBorder(
        side: BorderSide(
            color: isSelected ? Color(0xffe94057) : Colors.grey[400]!),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Color(0xffe94057) : Colors.black,
        ),
      ),
    );
  }
}
