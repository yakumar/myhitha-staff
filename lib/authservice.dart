import 'package:flutter/material.dart';
import './login.dart';
// import '../homeCard.dart';
// import '../cart.dart';
// import '../checkout.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './myHome.dart';

// abstract class AuthServiceBase {
//   handleAuth();
//   signOut();
//   signIn(AuthCredential authCreds, BuildContext context);
//   signInWithOTP(String smsCode, String verId, BuildContext context);
// }

// final myNotifierProvider = ChangeNotifierProvider((_) {
//   return AuthService();
// });

class AuthService {
  checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null) {
      return true;
    } else {
      return false;
    }

    // FirebaseAuth.instance.authStateChanges().listen((User user) {
    // if (user != null) {
    //   return true;
    // } else {
    //   return false;
    // }
    // });
  }

  // @override
  handleAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null) {
      Get.off(Login());
    } else {
      Get.to(MyHome());
    }

    // FirebaseAuth.instance.authStateChanges().listen((User user) {
    //   if (user == null) {
    //     Get.off(Login());
    //   } else {
    //     Get.to(Checkout());
    //   }
    // }
    // );
  }

  signOut() {
    // FirebaseAuth.instance.signOut();
    // Get.offAll(HomeCard());
  }

  //SignIn
  // @override

}
