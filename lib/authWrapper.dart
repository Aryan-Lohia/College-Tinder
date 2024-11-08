import 'package:college_tinder/screens/common/loadingScreen.dart';
import 'package:college_tinder/screens/login/backend.dart';
import 'package:college_tinder/screens/profile/profCreation/profileCreationScreen1.dart';
import 'package:college_tinder/screens/profile/profCreation/profileCreationScreen2.dart';
import 'package:college_tinder/screens/profile/profCreation/profileCreationScreen3.dart';
import 'package:college_tinder/screens/profile/profCreation/profileCreationScreen4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/splash/splashScreen.dart';
import 'screens/homeLayout/homeLayout.dart';


class AuthWrapper extends StatefulWidget {
  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Authentication>(context); // Listen to changes in authProvider
    if (authProvider.currentUser != null) {
      // User is signed in
      if (authProvider.userRegistered != null) {
        if (authProvider.userRegistered!['created'] && !authProvider.userRegistered!['exists']) {
          // User is created but doesn't exist in the database, show profile creation screen
          Navigator.popUntil(context, (route)=>route.isFirst);
          return const ProfileCreationScreen1();
        } else if (!authProvider.userRegistered!['created'] && authProvider.userRegistered!['exists']) {
          // User exists, show home layout
          if(authProvider.userProfile!=null){
          Navigator.popUntil(context, (route)=>route.isFirst);
          switch(authProvider.userProfile!.onboarding_completed!){
            case 0:return ProfileCreationScreen1();
            case 1:return ProfileCreationScreen2();
            case 2:return ProfileCreationScreen3();
            case 3:return ProfileCreationScreen4();
            default:return HomeLayout();
          }
          }
          else {
            // Waiting for registration status
            Navigator.popUntil(context, (route)=>route.isFirst);
            return const LoadingScreen();
          }

        } else {
          // Waiting for registration status
          Navigator.popUntil(context, (route)=>route.isFirst);
          return const LoadingScreen();
        }
      } else {
        // Registration status is null, show loading
        Navigator.popUntil(context, (route)=>route.isFirst);
        return const LoadingScreen();
      }
    } else {
      // User is not signed in, show SplashScreen
      Navigator.popUntil(context, (route)=>route.isFirst);
      return const SplashScreen();
    }
  }
}
