import 'package:flutter/foundation.dart';

ValueNotifier<int> selectedScreen=ValueNotifier(0);

void setSelectedScreen(int value){
selectedScreen.value=value;
}