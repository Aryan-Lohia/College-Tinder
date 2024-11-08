import 'dart:convert';
import 'dart:io';
import 'package:college_tinder/screens/common/loadingScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../common/components/datePicker.dart';
import '../../../secrets.dart';
import '../../login/backend.dart';
import 'profileCreationScreen2.dart';
import 'package:http/http.dart' as http;
import '../../../common/components/buttonDesign.dart';

class ProfileCreationScreen1 extends StatefulWidget {
  const ProfileCreationScreen1({super.key});

  @override
  State<ProfileCreationScreen1> createState() => _ProfileCreationScreen1State();
}

class _ProfileCreationScreen1State extends State<ProfileCreationScreen1> {
  DateTime? selectedDate;
  XFile? _profileImage;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool isLoading=false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  Future<void> _openDatePicker(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: BottomSheetDatePicker(
            initialDate: selectedDate ?? DateTime(1995, 7, 11),
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
            lastDate: DateTime.now(),
          ),
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = image;
      });
    }
  }
  Future<void> _sendData(Map<String, dynamic> userData) async {
    setState(() {
      isLoading=true;
    });
    final url = '${Secret.BASE_URL}/users/update'; // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};
    String? profile_image_url=userData['profile_image_url'];
    if(profile_image_url!=null && profile_image_url!=""){
       profile_image_url=await _uploadProfileImage(profile_image_url);
    }
    if(profile_image_url!=null){
      userData['profile_image_url']=profile_image_url;
    }
    else{
      userData['profile_image_url']="https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg";
    }
    final body = jsonEncode(userData);
    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => const ProfileCreationScreen2()));
      } else {
        Fluttertoast.showToast(
          msg: "Check your internet and try again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print('Failed to submit data: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
    setState(() {
      isLoading=false;
    });
  }
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? getFileExtension(String fileName) {
    try {
      return fileName.split('.').last;
    } catch(e){
      return null;
    }
  }
  // Function to upload image to Firebase Storage
  Future<String?> _uploadProfileImage(String profileImagePath) async {
    try {
      File file = File(profileImagePath);

      Reference storageRef = _storage.ref().child('profileImages/${DateTime.now().millisecondsSinceEpoch}.${getFileExtension(profileImagePath)}');
      UploadTask uploadTask = storageRef.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL(); // Return the download URL of the uploaded image
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }


  void _onConfirm() {
    final authProvider = Provider.of<Authentication>(context, listen: false);
    if (_formKey.currentState?.validate() ?? false) {
      // Prepare the user data in a map
      Map<String, dynamic> userData = {
        "auth_id":authProvider.userProfile!.authId,
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
        "dob": selectedDate != null
            ? DateFormat.yMMMMd().format(selectedDate!)
            : null,
        "profile_image_url":  _profileImage?.path?? "",
        "onboarding_completed":1,
      };

      // Navigate to the next screen and pass the user data
    _sendData(userData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading?
    const LoadingScreen():Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(30, 100, 30, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         CupertinoPageRoute(
              //           builder: (context) => const ProfileCreationScreen2(userData: { "firstName": "",
              //             "lastName": "",
              //             "birthday": null,
              //             "profileImagePath": "",},),
              //         ),
              //       );
              //     },
              //     child: Text(
              //       "Skip",
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 18,
              //         color: Color(0xffe94057),
              //       ),
              //     ),
              //   ),
              // ),
              Spacer(),
              const Text(
                "Profile Details",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 80),
              Center(
                child: Container(
                  height: 105,
                  width: 105,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: _profileImage != null
                                ? DecorationImage(
                              image: FileImage(File(_profileImage!.path)),
                              fit: BoxFit.cover,
                            )
                                : const DecorationImage(
                              image: AssetImage("assets/defaultProfilePhoto.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffe94057),
                          child: IconButton(
                            onPressed: _pickImage,
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _firstNameController,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: "First Name",
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _lastNameController,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: "Last Name",
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () => _openDatePicker(context),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xffe94057).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Color(0xffe94057),
                        ),
                        SizedBox(width: 20),
                        Text(
                          selectedDate != null
                              ? DateFormat.yMMMMd().format(selectedDate!)
                              : "Choose Birthday date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xffe94057),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: _onConfirm,
                  child: MainButtonDesign(text: "Confirm"),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
