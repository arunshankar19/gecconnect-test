import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      home: const Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: FutureBuilder(
        future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
        builder:(context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.done:
              return Column(children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(
              hintText: 'Enter your Email',
            ),
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Password'),
            controller: _password,
          ),
          TextButton(
              onPressed: () async {
                await Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                );
                final email = _email.text;
                final pass = _password.text;
                try {
                  final userCred = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(email: email, password: pass);
                print(userCred);
                }
                on FirebaseAuthException catch(e) {
                  switch(e.code) {
                    case 'invalid-email' : print('Invaid Email');
                    break;
                    case 'wrong-password' : print('Wrong credentials');
                    break;
                    case 'user-not-found' : print('no user found');
                    break;
                  }
                  print(e.code);
                }
              },
              child: const Text('Login'))
        ]);
        default: return Text('Loading.....');
          }
          
        }, 
      ),
    );
  }
}
