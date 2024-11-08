import 'dart:convert';
import 'dart:io';
import 'package:college_tinder/secrets.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:college_tinder/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileEditForm extends StatefulWidget {
  final UserModel user;

  const ProfileEditForm({super.key, required this.user});
  @override
  _ProfileEditFormState createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  String? profileImage;
  String firstName = "";
  String lastName = "";
  String? selectedGender;
  String? interestedIn;
  List<String> selectedInterests = [];
  final List<Map<String, dynamic>> interests = [
    {'name': 'Photography', 'icon': Icons.camera_alt},
    {'name': 'Shopping', 'icon': Icons.shopping_bag},
    {'name': 'Karaoke', 'icon': Icons.mic},
    {'name': 'Yoga', 'icon': Icons.sports_handball},
    {'name': 'Cooking', 'icon': Icons.ramen_dining},
    {'name': 'Tennis', 'icon': Icons.sports_tennis},
    {'name': 'Run', 'icon': Icons.directions_run},
    {'name': 'Swimming', 'icon': Icons.pool},
    {'name': 'Art', 'icon': Icons.palette},
    {'name': 'Traveling', 'icon': Icons.terrain},
    {'name': 'Extreme', 'icon': Icons.diamond},
    {'name': 'Music', 'icon': Icons.music_note},
    {'name': 'Drink', 'icon': Icons.local_bar},
    {'name': 'Video games', 'icon': Icons.sports_esports},
  ];
  List<String> gallery = [];
  List<String> galleryDownloadUrls = [];

  final _picker = ImagePicker();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  bool  isLoading=false;

  @override
  void initState() {
    super.initState();
    firstName = widget.user.firstName!;
    lastName = widget.user.lastName!;
    selectedGender = widget.user.gender;
    interestedIn = widget.user.interestedIn;
    selectedInterests = widget.user.hobbies ?? [];
    galleryDownloadUrls = widget.user.images ?? [];
  }

  Future<void> _pickProfileImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImage = pickedFile.path;
      });
    }
  }

  Future<void> _pickGalleryImages() async {
    final List<XFile> pickedFiles =
        await _picker.pickMultiImage(limit: 5 - (gallery.length+galleryDownloadUrls.length));
    for (var file in pickedFiles) {
      gallery.add(file.path);
    }
    setState(() {
    });
    }

  Future<void> _uploadImages() async {
    try {
      List<String> downloadUrls = [];

      // Upload profile image if it exists
      if (profileImage != null) {
        String profileImageUrl = await _uploadFile(
            File(profileImage!), 'profileImages/${DateTime.now()}.jpg');
        profileImage=profileImageUrl;
        print(profileImage);
      }

      // Upload gallery images if any
      if (gallery.isNotEmpty) {
        for (String path in gallery) {
          String downloadUrl = await _uploadFile(
              File(path), 'gallery_images/${DateTime.now()}.jpg');
          downloadUrls.add(downloadUrl);
        }
      }

      setState(() {
        galleryDownloadUrls.addAll(downloadUrls);
      });
      print('All images uploaded successfully. URLs: $galleryDownloadUrls');
    } catch (e) {
      print('Error while uploading: $e');
    }
  }

  Future<String> _uploadFile(File file, String path) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(path).putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _submitData() async {
    setState(() {
      isLoading=true;
    });
    await _uploadImages(); // This uploads images and updates the galleryDownloadUrls and profileImage
    var url = Uri.parse("${Secret.BASE_URL}/users/update");
    var body = jsonEncode({
      'auth_id':widget.user.authId,
      'firstName': firstName,
      'lastName': lastName,
      'gender': selectedGender,
      'interested_in': interestedIn,
      'selectedHobbies': selectedInterests,
      'images': galleryDownloadUrls,
      'profile_image_url': profileImage,
    });
    try {
      var response = await http
          .post(url, body: body, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        print("Profile updated successfully");
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
        print("Failed to update profile");
      }
    } catch (e) {
      print("Error while updating profile: $e");
    }
    setState(() {
      isLoading=false;
    });
  }

  void _removeImage(int index) {
    setState(() {
      galleryDownloadUrls.removeAt(index);
    });
  }void _removeGalleryImage(int index) {
    setState(() {
      gallery.removeAt(index);
    });
  }

  Widget _buildSelectableCard({
    required String title,
    required String? selectedValue,
    required String value,
    required Function(String) onTap,
  }) {
    bool isSelected = selectedValue == value;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Card(
        color: isSelected ? Color(0xffe94057) : Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: isSelected ? Color(0xffe94057) : Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            icon: Icon(Icons.chevron_left)),
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Profile Image Upload
            Center(
              child: GestureDetector(
                onTap: _pickProfileImage,
                child:Center(
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
                              image:  DecorationImage(
                                image: profileImage != null
                                    ? FileImage(File(profileImage!))
                                    : widget.user.profilePicUrl != null
                                    ? NetworkImage(widget.user.profilePicUrl!)
                                    : NetworkImage("https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg"),
                                fit: BoxFit.cover,
                              )

                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xffe94057),
                            child: IconButton(
                              onPressed: _pickProfileImage,
                              icon:profileImage == null && widget.user.profilePicUrl == null
                                  ? const Icon(
                              Icons.camera_alt,
                              size: 15,
                            )
                                : const Icon(
                            Icons.edit,
                            size: 15,
                            color: Colors.white,
                          ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // First Name Input
            TextField(
              decoration: InputDecoration(labelText: "First Name",  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xffe94057) ))
              ),
              controller: TextEditingController(text: firstName),
              onChanged: (value) {
                setState(() {
                  firstName = value;
                });
              },
            ),
SizedBox(height: 20,),
            // Last Name Input
            TextField(
              decoration: InputDecoration(
                  labelText: "Last Name",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xffe94057) ))

              ),
              controller: TextEditingController(text: lastName),
              onChanged: (value) {
                setState(() {
                  lastName = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Gender Selection Cards
            Text("Gender"),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSelectableCard(
                  title: "Male",
                  selectedValue: selectedGender,
                  value: "0",
                  onTap: (value) {
                    setState(() {
                      selectedGender = '0';
                    });
                  },
                ),
                _buildSelectableCard(
                  title: "Female",
                  selectedValue: selectedGender,
                  value: "1",
                  onTap: (value) {
                    setState(() {
                      selectedGender = '1';
                    });
                  },
                ),
                _buildSelectableCard(
                  title: "Other",
                  selectedValue: selectedGender,
                  value: "2",
                  onTap: (value) {
                    setState(() {
                      selectedGender = '2';
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Interested In Selection Cards
            Text("Interested In"),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSelectableCard(
                  title: "Men",
                  selectedValue: interestedIn,
                  value: "0",
                  onTap: (value) {
                    setState(() {
                      interestedIn = '0';
                    });
                  },
                ),
                _buildSelectableCard(
                  title: "Women",
                  selectedValue: interestedIn,
                  value: "1",
                  onTap: (value) {
                    setState(() {
                      interestedIn = '1';
                    });
                  },
                ),
                _buildSelectableCard(
                  title: "Both",
                  selectedValue: interestedIn,
                  value: "2",
                  onTap: (value) {
                    setState(() {
                      interestedIn = '2';
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Interests Selection Chips
            Text("Interests"),
            SizedBox(height: 10),

            Wrap(
              spacing: 8,
              children: interests.map((Map interest) {
                return ChoiceChip(
                  backgroundColor: Colors.white,
                  showCheckmark: false,
                  avatar: Icon(
                    interest['icon'],
                    color: selectedInterests.contains(interest['name'])
                        ? Colors.white
                        : Colors.black,
                  ),
                  selectedColor: Color(0xffe94057),
                  labelStyle: TextStyle(
                      color: selectedInterests.contains(interest['name'])
                          ? Colors.white
                          : Colors.black),
                  label: Text(interest['name']),
                  selected: selectedInterests.contains(interest['name']),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedInterests.add(interest['name']);
                      } else {
                        selectedInterests.remove(interest['name']);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Gallery Upload
            Text("Gallery (Max 5 Photos)"),
            SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children:[
                for(var i=0;i<galleryDownloadUrls.length;i++)
                 Stack(
                  children: [
                    Image.network(galleryDownloadUrls[i], width: 80, height: 80,fit: BoxFit.cover,),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeImage(i),
                      ),
                    )
                  ],
                ),
                for(var i=0;i<gallery.length;i++)
                 Container(
                   height: 80,
                   width: 80,
                   child: Stack(
                    children: [
                      Image.asset(gallery[i], width: 80, height: 80,fit: BoxFit.cover,),
                      Positioned(
                        right: 0,
                        top: 0,
                        child:  IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeGalleryImage(i),
                        ),
                      )
                    ],
                                   ),
                 ),]
                   ),
            if (galleryDownloadUrls.length+gallery.length< 5)
              InkWell(
                onTap: () async {
                  await _pickGalleryImages();
                },
                child:Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Color(0xffe94057).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  child: Center(
                    child: const Text(
                      'Upload Photos',
                      style: TextStyle(fontSize: 18,color: Color(0xffe94057),fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

              ),
            SizedBox(height: 20),

            // Submit Button
            InkWell(
              onTap: () async {
                try {


                  // Once the images are uploaded, submit the data to the server
                  await _submitData();

                  // If everything is successful, close the loading indicator and navigate back
                  Navigator.pop(context);  // To close the dialog
                  Fluttertoast.showToast(
                    msg: "Profile updated successfully!",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } catch (e) {
                  // Close the loading indicator and show an error message if something goes wrong
                  Navigator.pop(context);  // To close the dialog
                  Fluttertoast.showToast(
                    msg: "Failed to update profile. Please try again.",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  print("Error while updating profile: $e");
                }
              },
              child:Container(
                decoration: BoxDecoration(
                  color: Color(0xffe94057),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                child: Center(
                  child: const Text(
                    'Update Profile',
                    style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
