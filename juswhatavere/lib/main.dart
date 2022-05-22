import 'package:flutter/material.dart';
import 'package:juswhatavere/models/user_costume.dart';
import 'package:juswhatavere/screens/home/home.dart';
import 'package:juswhatavere/screens/services/auth.dart';
import 'package:juswhatavere/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:juswhatavere/shared/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserCostume?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Loading();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Wrapper();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
      )

      ),
    );
  }
}

