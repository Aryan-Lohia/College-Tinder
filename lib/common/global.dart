import 'package:flutter/foundation.dart';

ValueNotifier<int> selectedScreen=ValueNotifier(0);

void setSelectedScreen(int value){
selectedScreen.value=value;
}

enum swiperAction{
  like,dislike
}

int calculateAge(DateTime dob) {
  final today = DateTime.now();
  int age = today.year - dob.year;

  // Check if the birthday has not occurred this year yet
  if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
    age--;
  }

  return age;
}