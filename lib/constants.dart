import 'dart:math';

const String PROJECT_ID = "fir-intro-5897d";
const String APP_ID = "1:774307122059:android:61550734d052d96a3f3d8e";
const String API_KEY = "AIzaSyAW8OG_3aed8rdAA9Axq5ISx71ixRhFpE8";
const String SENDER_ID = "774307122059";
const String DB_URL = "https://fir-intro-5897d-default-rtdb.firebaseio.com/";




String getRandomDrink() {
  final drinkList = [
    'Latte',
    'Cappuccino',
    'Macchiato',
    'Cortado',
    'Mocha',
    'Drip coffee',
    'Cold brew',
    'Espresso',
    'Vanilla latte',
    'Unicorn frappe'
  ];

  return drinkList[Random().nextInt(drinkList.length)];
}

String getRandomName() {
  final customerNames = [
    'Lok',
    'Caps',
    'Max',
    'Cortnet',
    'Macha',
    'David',
    'Sumit',
    'Peter',
    'Vineel',
    'Coco'
  ];

  return customerNames[Random().nextInt(customerNames.length)];
}