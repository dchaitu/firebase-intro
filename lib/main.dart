import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_intro/constants.dart';
import 'package:firebase_intro/views/read_examples.dart';
import 'package:firebase_intro/views/write_examples.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbIntroApp = Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: API_KEY,
        appId: APP_ID,
        messagingSenderId: SENDER_ID,
        projectId: PROJECT_ID,
        authDomain: '${PROJECT_ID}.firebaseapp.com',
        databaseURL: DB_URL,
        storageBucket: '${PROJECT_ID}.appspot.com',
      ));

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Hey check out some examples"),
            SizedBox(height: 6, width: MediaQuery.of(context).size.width),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ReadExamples()) );
                }, child: const Text("Read Examples")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const WriteExamples()) );

                }, child: const Text("Write Examples"))
          ],
        ),
      ),
    );
  }
}
