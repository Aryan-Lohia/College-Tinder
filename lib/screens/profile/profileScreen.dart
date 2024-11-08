import 'dart:convert';

import 'package:college_tinder/common/global.dart';
import 'package:college_tinder/models/UserModel.dart';
import 'package:college_tinder/screens/profile/editProfileScreen.dart';
import 'package:college_tinder/screens/profile/profileAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../secrets.dart';
import '../login/backend.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel userData;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
  const ProfileScreen({super.key, required this.userData});

}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isOwnProfile=false;
  bool isMatch=false;
  bool isLoading=false;
  ProfileController controller=ProfileController();

  @override
  void initState(){
    super.initState();
    final authProvider = Provider.of<Authentication>(context,listen: false);
    isOwnProfile=widget.userData.id==authProvider.userProfile!.id;
      if(!isOwnProfile){
        fetchData();
      }
      print(widget.userData);
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading=true;
    });
    final authProvider = Provider.of<Authentication>(context,listen: false);
    await controller.checkIfMatch(authProvider.userProfile!.id!,widget.userData.id!);
    setState(() {
      isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Authentication>(context,listen: false);

    return Scaffold(
      body: SizedBox(
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
                  image: NetworkImage(
                      widget.userData.profilePicUrl??""
                  ), // Replace with your image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !isOwnProfile?Row(
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
                ):Container(),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.userData.firstName!}, ${calculateAge(widget.userData.dob!)}',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        widget.userData.bio!=null && widget.userData.bio!=''?Text('${widget.userData.bio!}',
                            style: TextStyle(fontSize:14,color: Colors.black)):Container(),
                      ],
                    ),
                    !isOwnProfile?InkWell(
                      onTap: (){},
                      child: Image.asset('assets/send.png'),
                    ):InkWell(
                      enableFeedback: false,
                      splashColor: Colors.transparent,
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>ProfileEditForm(user: widget.userData,)));
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 19,
                            child: Icon(Icons.edit)),
                      ),
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
                widget.userData.about!=null && widget.userData.about!=''?Column(
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                        widget.userData.about!
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
                  ],
                ):Container(),
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
                    for(var interest in widget.userData.hobbies??[])
                    _buildInterestChip(interest,isSelected: isOwnProfile?false:authProvider.userProfile!.hobbies?.contains(interest)??false),

                  ],
                ),
                SizedBox(height: 20,),
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

                      ],
                    ),
                    SizedBox(height: 20),
                    // First Row with 2 images
                    widget.userData.images !=null && widget.userData.images!.length>0?Row(
                      children: [
                        widget.userData.images !=null && widget.userData.images!.length>=1?Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              widget.userData.images![0],
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          ),
                        ):Container(),
                        SizedBox(width: 10),
                        widget.userData.images !=null && widget.userData.images!.length>=2?Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              widget.userData.images![1],
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          ),
                        ):Container(),
                      ],
                    ):Container(
                      padding: EdgeInsets.all(30),
                      child: Center(child: Text("No Images Posted"),),
                    ),
                    SizedBox(height: 10),
                    // Second Row with 3 images
                    Row(
                      children: [
                        widget.userData.images !=null && widget.userData.images!.length>=3?Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              widget.userData.images![2],
                              fit: BoxFit.cover,
                              height: 130,
                            ),
                          ),
                        ):Container(),
                        SizedBox(width: 10),
                        widget.userData.images !=null && widget.userData.images!.length>=4?Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              widget.userData.images![3],
                              fit: BoxFit.cover,
                              height: 130,
                            ),
                          ),
                        ):Container(),
                        SizedBox(width: 10),
                        widget.userData.images !=null && widget.userData.images!.length>=5?Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              widget.userData.images![4],
                              fit: BoxFit.cover,
                              height: 130,
                            ),
                          ),
                        ):Container(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )


            ),

        ]),


      ),
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
