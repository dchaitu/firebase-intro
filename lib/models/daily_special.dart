class DailySpecial {
  final double price;
  final String description;

  DailySpecial({required this.price, required this.description});

  factory DailySpecial.fromRTDB(Map<String, dynamic> data) {
    return DailySpecial(
        price: data['price'] ?? 0.0,
        description: data['description'] ?? 'Drink');
  }

  String formattedDescription() {
    return "Today's Special $description at a special price ${price.toStringAsFixed(2)}";
  }
}
