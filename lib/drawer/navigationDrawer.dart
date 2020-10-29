// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:myhitha/components/homeCard.dart';
// import 'package:myhitha/components/orders.dart';
import './drawerBody.dart';
import './drawerHeader.dart';
// import '../auth/authservice.dart';
import 'package:get/get.dart';
import '../myHome.dart';
import '../todayStock.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            createDrawerHeader(),
            createDrawerBody(
                icon: Icons.home,
                text: 'Home',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MyHome()))),
            // Divider(),
            // createDrawerBody(
            //     icon: Icons.arrow_drop_down_circle,
            //     text: AuthService().checkAuth() == true ? 'Login' : 'Logout',
            //     onTap: () => null),
            Divider(),
            createDrawerBody(
                icon: Icons.shopping_basket,
                text: 'Today Stock',
                onTap: () => {
                      // Get.off(TodayStock())
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) => TodayStock())

                          // debugPrint(
                          //     'User:: ${FirebaseAuth.instance.currentUser.phoneNumber}'),
                          // FirebaseAuth.instance.currentUser != null
                          //     ? Get.to(
                          //         Orders(
                          //             phone: FirebaseAuth
                          //                 .instance.currentUser.phoneNumber),
                          //         arguments: '${FirebaseAuth.instance.currentUser}')
                          //     : null
                          )
                    }),
          ],
        ),
      ),
    );
  }
}
