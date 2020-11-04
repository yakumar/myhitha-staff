import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc/simple_observer.dart';
import './myHome.dart';
import './todayStock.dart';
import './login.dart';
import './editFinalOrder.dart';
import './authservice.dart';
import './bloc/editorder_bloc.dart';
import './bloc/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleObserver();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');

  runApp(MyApp(token));
}

class MyApp extends StatelessWidget {
  final String token;
  MyApp(this.token);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // BlocProvider<CounterCubit>(
          //   create: (context) => CounterCubit(),
          // ),
          BlocProvider<EditorderBloc>(
              create: (_) => EditorderBloc(EditOrderRepository())),
        ],
        child: GetMaterialApp(
          title: 'Myhitha Staff',
          theme: ThemeData(
            buttonTheme: ButtonThemeData(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                buttonColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 4.0)),
            primarySwatch: Colors.orangeAccent[800],
            primaryColor: Colors.orangeAccent[800],
            appBarTheme: AppBarTheme(color: Colors.orangeAccent),
            // brightness: Brightness.dark,
            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => token != null ? MyHome() : Login(),
            '/login': (context) => token != null ? MyHome() : Login(),
            '/myHome': (context) => token != null ? MyHome() : Login(),
            // '/cart': (context) => Cart(),
            '/todayStock': (context) => token != null ? TodayStock() : Login(),
            '/editFinalOrder': (context) => EditFinalOrder(),
          },
        ));
  }
}
