import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './utilities/sizes.dart';
import './authservice.dart';
import 'package:get/get.dart';
import './myHome.dart';
// import '../homeCard.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String phone, password;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  bool codeSent = false;
  bool checkBoxValue = false;

  // @override
  // void dispose() {
  //   //profileBloc.dispose() cannot call as ProfileBloc class doesn't have dispose method
  //   super.dispose();
  // }

  void autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //  var autoLogin = prefs.getInt('autoLogin') ??
    // still don't know what this is, a boolean?
    if (prefs.getString('phone') != null &&
        prefs.getString('password') != null) {
      setState(() {
        _phoneController.text = prefs.getString('phone');
        _passController.text = prefs.getString('password');
      });
    }
  }

  _checkBoxClicked(bool val) {
    print('before check, $checkBoxValue');

    setState(() {
      checkBoxValue = !checkBoxValue;
    });

    print('after check, $checkBoxValue');
  }

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[700],
      resizeToAvoidBottomPadding: false,
      body: Container(
        // color: Colors.orange[700],
        // width: displayWidth(context) / 2,
        margin: EdgeInsets.symmetric(
            horizontal: displayWidth(context) / 18,
            vertical: displayHeight(context) / 4),
        height: displayHeight(context) / 2,
        alignment: Alignment.center,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(20.0),
        //   color: Colors.orange[700],
        // ),

        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "MyHitha Staff Login",
                  style: TextStyle(fontSize: 25.0, color: Colors.black87),
                ),
                Container(
                  height: displayHeight(context) / 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: displayWidth(context) / 9),
                  child: TextFormField(
                    controller: _phoneController,
                    // initialValue: '',
                    maxLength: 10,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 20.0),
                      prefixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 12.0),
                        child:
                            Icon(Icons.phone), // myIcon is a 48px-wide widget.
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'phone',
                    ),
                    keyboardType: TextInputType.phone,
                    onSaved: (val) {
                      setState(() {
                        phone = val;
                      });
                    },
                    textAlignVertical: TextAlignVertical.bottom,

                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter phone';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  height: displayHeight(context) / 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: displayWidth(context) / 9),
                  child: TextFormField(
                    // initialValue: '',

                    controller: _passController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10.0),
                      prefixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 12.0),
                        child:
                            Icon(Icons.lock), // myIcon is a 48px-wide widget.
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'password',
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    onSaved: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                    textAlignVertical: TextAlignVertical.bottom,

                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 6) {
                        return 'Please enter more than 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        _signIn(phone, password);

                        // codeSent
                        //     ? AuthService()
                        //         .signInWithOTP(smsCode, verificationId, context)
                        //     : verifyPhone(phoneNo, context);
                      }
                    },
                    child: Text('Login'),
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox

                          title: Text(
                            "Remember me",
                            style: TextStyle(color: Colors.black),
                          ),
                          value: checkBoxValue,
                          onChanged: _checkBoxClicked,
                        ),
                      ),
                      // Flexible(child: Text('Remember'))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn(String phoney, String passwordy) async {
    print('runtimetypy ${phoney}');
    print('runtimetypy ${passwordy}');

    try {
      Map data = {'phone': phoney, 'password': passwordy};

      //encode Map to JSON
      var body = json.encode(data);

      final response = await http.post(
          "https://arcane-springs-88980.herokuapp.com/signin",
          headers: {"Content-Type": "application/json"},
          body: body);

      if (response.statusCode == 200) {
        var phonePersist = phoney;
        var passwordPersist = passwordy;

        // print('Response from dB: ${json.decode(response.body)['token']}');
        // Map<String, dynamic> tempList = json.decode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString('token', json.decode(response.body)['token']);

        if (checkBoxValue == true) {
          if (prefs.getString('phone') != null &&
              prefs.getString('password') != null) {
            print('phoney, $phoney');
            print('phoney, $phonePersist');

            prefs.remove('phone');
            prefs.remove('password');
            prefs.setString('phone', phoney);
            prefs.setString('password', passwordy);
            phonePersist = "";

            passwordPersist = "";
          } else {
            prefs.setString('phone', phoney);
            prefs.setString('password', passwordy);
          }
        } else {}

        Get.off(MyHome());

        // print('DATED LIST ==>  ==> , ${_datedList}');

        // print(
        //     'Returning FUTURE ==>> ,${_datedList.map((pro) => Order.fromJson(pro)).toList()}');

      } else {
        throw Exception('Failed to load list');
      }
    } catch (e) {}
  }
  // final newUser = await _auth.signInWithphoneAndPassword(
  //     phone: phoney, password: passwordy);

  // if (newUser != null) {
  //   print('new User: ${newUser}');
  //   if (checkBoxValue) {
  //     SharedPreferences loginPrefs = await SharedPreferences.getInstance();
  //     if (loginPrefs.getString('phone') != null &&
  //         loginPrefs.getString('password') != null) {
  //       loginPrefs.clear();
  //       loginPrefs.setString('phone', '${phonePersist}');
  //       loginPrefs.setString('password', '$passwordPersist');
  //       phonePersist = "";

  //       passwordPersist = "";
  //     }
  //   }

  // Get.off(HomeCard());
  // } else {}

  // Future<void> verifyPhone(phoneNo, BuildContext context) async {
  //   final PhoneVerificationCompleted verified = (AuthCredential authResult) {
  //     AuthService().signIn(authResult, context);
  //   };

  //   final PhoneVerificationFailed verificationfailed =
  //       (FirebaseAuthException authException) {
  //     print('${authException.message}');
  //   };

  //   final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
  //     this.verificationId = verId;
  //     setState(() {
  //       this.codeSent = true;
  //     });
  //   };

  //   final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
  //     this.verificationId = verId;
  //   };

  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: phoneNo,
  //       timeout: const Duration(seconds: 0),
  //       verificationCompleted: verified,
  //       verificationFailed: verificationfailed,
  //       codeSent: smsSent,
  //       codeAutoRetrievalTimeout: autoTimeout);
  // }
}
