import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_intro/models/daily_special.dart';
import 'package:firebase_intro/models/order.dart';
import 'package:firebase_intro/models/order_stream_publisher.dart';
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

              const SizedBox(height: 50),
              StreamBuilder(
                stream:
                    OrderStreamPublisher().getOrderStream(),
                builder: (context, snapshot) {
                  final tilesList = <ListTile>[];
                  if (snapshot.hasData ) {
                    final myOrders = snapshot.data as List<Order>;
                    tilesList.addAll(
                      myOrders.map((nextOrder) {
                        return ListTile(
                          leading: Icon(Icons.local_cafe),
                          title: Text(nextOrder.description),
                          subtitle: Text(nextOrder.customerName),
                        );
                      }),
                    );
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
