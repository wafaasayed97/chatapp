import 'package:chat_app/presentation/screens/home_screen.dart';
import 'package:chat_app/presentation/screens/log_in_screen.dart';
import 'package:chat_app/presentation/screens/notification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'cache_helper.dart';
import 'constant/app_constant.dart';
import 'data/data_source/firebase_api.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FireBaseApi().initNotification();

  await CacheHelper.init();
  id = CacheHelper.getData(key: 'id');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chats',
        routes: {
          '/notification_screen':(context)=> NotificationScreen(),
        },
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:
            FirebaseAuth.instance.currentUser == null ? LogIn() : HomeScreen());
  }
}
