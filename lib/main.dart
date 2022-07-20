import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gecconnect/views/emailverify_view.dart';
import 'package:gecconnect/views/login_view.dart';
import 'package:gecconnect/views/register_view.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/login/':(context) => const Login(),
        '/register/':(context) => const Register(),
        '/verify/':(context) => const VerifyEmail()
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          
          case ConnectionState.done:
          final user = FirebaseAuth.instance.currentUser;
          if (user?.emailVerified ?? false) {
            return const Login();
          }
          else {
            // Navigator.of(context).pushNamedAndRemoveUntil('/veify/', (route) => false); 
            return const VerifyEmail();           
          }
          default:
          // Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
          return const Login();
          // return const Text('Loading....');
        }
      },);
  }
}
