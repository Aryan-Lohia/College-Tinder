import 'dart:io' show Platform;

class Secret {
  static const ANDROID_CLIENT_ID = "973852464632-5uenlj952gv8d4f1vqqs3qek19bnb1s3.apps.googleusercontent.com";
  static const IOS_CLIENT_ID = "973852464632-s2iq0lhcf037ug5iu1odscrlqe7ih1r5.apps.googleusercontent.com";
  static String getId() => Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.IOS_CLIENT_ID;
  static String BASE_URL="http://127.0.0.1:9000";
}