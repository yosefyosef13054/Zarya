class Cart {
  final int itemId;
  int quantity;
  final double commission;
  final String image;
  final String name;
  final double price;
  final double itemEarning;

  Cart({
    required this.commission,
    required this.itemId,
    required this.quantity,
    required this.image,
    required this.name,
    required this.price,
    this.itemEarning = 0.0,
  });
}
