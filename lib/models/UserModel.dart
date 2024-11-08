class UserModel {
  final int? id;
  final String? authId;
  final String? phone;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final DateTime? dob;
  final String? bio;
  final String? about;
  final String? profilePicUrl;
  final double? latitude;
  final double? longitude;
  final List<String>? hobbies;
  final List<String>? images;
  final String? interestedIn;
  final bool? isActive;
  final int? onboarding_completed;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.id,
    this.authId,
    this.phone,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.dob,
    this.bio,
    this.about,
    this.profilePicUrl,
    this.latitude,
    this.longitude,
    this.hobbies,
    this.images,
    this.interestedIn,
    this.isActive,
    this.onboarding_completed,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to create an instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      authId: json['auth_id'],
      phone: json['phone'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      bio: json['bio'],
      about: json['about'],
      profilePicUrl: json['profile_pic_url'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      hobbies: json['hobbies'] != null ? List<String>.from(json['hobbies']) : [],
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      interestedIn: json['interested_in'],
      isActive: json['is_active'],
      onboarding_completed: json['onboarding_completed'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  // Convert UserModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'auth_id': authId,
      'phone': phone,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'dob': dob?.toIso8601String(),
      'bio': bio,
      'about': about,
      'profile_pic_url': profilePicUrl,
      'latitude': latitude,
      'longitude': longitude,
      'hobbies': hobbies,
      'images': images,
      'interested_in': interestedIn,
      'is_active': isActive,
      'onboarding_completed': onboarding_completed,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
