class FinalCart {
  int itemId;
  int quantity;
  int commission;
  FinalCart({
    required this.commission,
    required this.itemId,
    required this.quantity,
  });

  // FinalCart.fromJson(Map<String, dynamic> json)
  //     : itemId = json['itemId'],
  //       quantity = json['quantity'],
  //       commission = json['commission'];

  // Map<String, dynamic> toJson() {
  //   return {
  //     'itemId': itemId,
  //     'quantity': quantity,
  //     'commission': commission,
  //   };
  // }
}
