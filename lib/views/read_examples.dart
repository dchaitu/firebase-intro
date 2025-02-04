import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_intro/models/daily_special.dart';
import 'package:flutter/material.dart';

class ReadExamples extends StatefulWidget {
  const ReadExamples({super.key});

  @override
  State<ReadExamples> createState() => _ReadExamplesState();
}

class _ReadExamplesState extends State<ReadExamples> {
  String _displayText = "Results";
  final _db = FirebaseDatabase.instance.ref();
  late StreamSubscription _dailySubscriptionStream;

  @override
  void initState() {
    listeners();
    // performSingleFetch();
    super.initState();
  }

  void listeners() {
    _dailySubscriptionStream =
        _db
            .child('dailySpecial')
            .onValue
            .listen((event) {
          final data = Map<String, dynamic>.from(
              event.snapshot.value as dynamic);
          final dailySpecial = DailySpecial.fromRTDB(data);
          setState(() {
            _displayText = dailySpecial.formattedDescription();
          });
        });
  }

  void performSingleFetch() {
    _db.child('dailySpecial').get().then((snapshot) {
      final data = Map<String, dynamic>.from(snapshot.value as dynamic);
      final dailySpecial = DailySpecial.fromRTDB(data);
      setState(() {
        _displayText = dailySpecial.formattedDescription();
      });
    });
  }

  @override
  void deactivate() {
    _dailySubscriptionStream.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read Examples"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(_displayText),
              const SizedBox(height: 20),
              StreamBuilder(
                stream:
                _db
                    .child('orders')
                    .orderByKey()
                    .limitToLast(10)
                    .onValue,
                builder: (context, snapshot) {
                  final tilesList = <ListTile>[];
                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null) {
                    final rawData = Map<dynamic, dynamic>.from(
                        snapshot.data!.snapshot.value as Map<dynamic, dynamic>);
                    if (rawData is Map<dynamic, dynamic>) {
                      final myOrders = rawData.map((key, value) => MapEntry(
                        key.toString(),
                        value is Map<dynamic, dynamic>
                            ? Map<String, dynamic>.from(value)
                            : {}, 
                      ));
                      myOrders.forEach((key, value) {
                        final nextOrder = Map<String, dynamic>.from(value);
                        final orderTile = ListTile(
                          leading: Icon(Icons.local_cafe),
                          title: Text(nextOrder['description']),
                          subtitle: Text(nextOrder['customer']),
                        );
                        tilesList.add(orderTile);
                      });
                    }
                  }
                  return Expanded(child: ListView(children: tilesList));
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
