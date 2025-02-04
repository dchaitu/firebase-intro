class Order {
  final String description;
  final String customerName;
  final double price;
  final DateTime timestamp;

  Order(
      {required this.description,
      required this.customerName,
      required this.price,
      required this.timestamp});

  factory Order.fromRTDB(Map<String, dynamic> data)
  {
    return Order(description: data['description']?? 'Drink',
        customerName: data['customerName'],
        price: data['price']?? 2.99,
        timestamp: (data['time']!=0)? DateTime.fromMicrosecondsSinceEpoch(data['time']) :DateTime.now()
    );
  }
}
