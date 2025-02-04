import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_intro/models/daily_special.dart';
import 'package:firebase_intro/models/order.dart';
import 'package:flutter/material.dart';

class ReadExamples extends StatelessWidget {
  final _db = FirebaseDatabase.instance.ref();

  ReadExamples({super.key});

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
              StreamBuilder(
                  stream: _db.child('dailySpecial').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final dailySpecial = DailySpecial.fromRTDB(
                          Map<String, dynamic>.from(snapshot
                              .data!.snapshot.value as Map<dynamic, dynamic>));
                      return Text(dailySpecial.formattedDescription());
                    } else
                      return CircularProgressIndicator();
                  }),

              const SizedBox(height: 20),
              StreamBuilder(
                stream:
                    _db.child('orders').orderByKey().limitToLast(10).onValue,
                builder: (context, snapshot) {
                  final tilesList = <ListTile>[];
                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null) {
                    final rawData = Map<dynamic, dynamic>.from(
                        snapshot.data!.snapshot.value as Map<dynamic, dynamic>);
                    if (rawData.isNotEmpty) {
                      final myOrders = rawData.map((key, value) => MapEntry(
                            key.toString(),
                            value is Map<dynamic, dynamic>
                                ? Map<String, dynamic>.from(value)
                                : {},
                          ));
                      myOrders.forEach((key, value) {
                        final nextOrder =
                            Order.fromRTDB(Map<String, dynamic>.from(value));
                        final orderTile = ListTile(
                          leading: Icon(Icons.local_cafe),
                          title: Text(nextOrder.description),
                          subtitle: Text(nextOrder.customerName),
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
