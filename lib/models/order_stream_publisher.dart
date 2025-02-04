import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_intro/models/order.dart';

class OrderStreamPublisher {
  final _db = FirebaseDatabase.instance.ref();

  Stream<List<Order>> getOrderStream() {
    final orderStream = _db.child('order').onValue;
    final streamPublish = orderStream.map((event) {
      final orderMap = Map<String, dynamic>.from(event.snapshot.value as Map<dynamic, dynamic>);
      final orderList = orderMap.entries.map((element)=> Order.fromRTDB(Map<String, dynamic>.from(element.value))).toList();

      return orderList;
    });
    return streamPublish;
  }
}
