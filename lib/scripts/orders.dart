import 'dart:math';

import 'package:firebase_intro/constants.dart';


var order = {
'description': getRandomDrink(),
'price': Random().nextInt(500),
'customer': getRandomName(),
'time': DateTime.now().millisecondsSinceEpoch,
};