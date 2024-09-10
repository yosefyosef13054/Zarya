class Order {
  Order({
    required this.id,
    required this.total,
    required this.commission,
    required this.shippingCharges,
    required this.userId,
    required this.merchantId,
    required this.statusId,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerCity,
    required this.cityId,
    required this.items,
    required this.placedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.courierId,
    required this.trackingNumber,
    required this.returnedForOrderId,
    required this.discount,
    required this.maxDiscount,
    required this.paymentStatusId,
    required this.courierCharges,
    required this.pending,
    required this.delivered,
  });

  int id;
  double total;
  double commission;
  double shippingCharges;
  int userId;
  int merchantId;
  int statusId;
  dynamic customerName;
  dynamic customerPhone;
  dynamic customerAddress;
  dynamic customerCity;
  dynamic cityId;
  List<dynamic> items;
  dynamic placedAt;
  int createdAt;
  int updatedAt;
  dynamic courierId;
  dynamic trackingNumber;
  dynamic returnedForOrderId;
  double discount;
  double maxDiscount;
  int paymentStatusId;
  double courierCharges;
  bool pending;
  bool delivered;
}

class Item {
  Item({
    required this.id,
    required this.itemId,
    required this.orderId,
    required this.quantity,
    required this.price,
    required this.total,
    required this.commission,
    required this.options,
    required this.createdAt,
    required this.updatedAt,
    required this.supplierSku,
    required this.name,
  });

  int id;
  int itemId;
  int orderId;
  int quantity;
  double price;
  double total;
  int commission;
  List<dynamic> options;
  int createdAt;
  int updatedAt;
  dynamic supplierSku;
  String name;
}
