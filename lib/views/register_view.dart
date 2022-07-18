import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gecconnect/firebase_options.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                final userCred = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(email: email, password: pass);
                print(userCred);
              },
              child: const Text('Register'))
        ]);
        default: return Text('Loading.....');
          }
          
        }, 
      ),
    );
  }
}