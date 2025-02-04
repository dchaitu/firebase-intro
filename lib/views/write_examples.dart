import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_intro/scripts/orders.dart';
import 'package:flutter/material.dart';

class WriteExamples extends StatefulWidget {
  const WriteExamples({super.key});

  @override
  State<WriteExamples> createState() => _WriteExamplesState();
}

class _WriteExamplesState extends State<WriteExamples> {
  final database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final dailySpecialRef = database.child('/dailySpecial');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Write Examples"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    try {
                      // await dailySpecialRef.set({
                      //   'description': 'Vanilla Latte',
                      //   'price': 5,
                      // });
                      // await dailySpecialRef.child('price').set(10);
                      // await dailySpecialRef.update({"quantity":100});
                      // await database.update({
                      //   "dailySpecial/price": 19,
                      //   "weekSpecial/price": 49});
                      final finalOrder = order;
                      database.child('orders').push().set(finalOrder);

                    } on FirebaseException catch (e) {
                      print("FirebaseException: ${e.message}");
                    } catch (error) {
                      print("Error: $error");
                    }
                  },
                  child: const Text("Simple Set"),
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      final finalOrder = order;
                      database.child('orders').push().set(finalOrder);

                    } on FirebaseException catch (e) {
                      print("FirebaseException: ${e.message}");
                    } catch (error) {
                      print("Error: $error");
                    }
                  },
                  child: const Text("Add an Order"))

            ],
          ),
        ),
      ),
    );
  }
}


