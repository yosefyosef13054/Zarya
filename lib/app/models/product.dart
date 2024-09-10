// class Product {
//   Product({
//     required this.items,
//     required this.marker,
//   });

//   List<Item> items;
//   String marker;
// }

class Product {
  Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.childCategoryId,
    required this.description,
    required this.price,
    required this.retailPrice,
    required this.quantity,
    required this.statusId,
    required this.options,
    required this.images,
    required this.thumbnail,
    required this.sortOrder,
    required this.marker,
    required this.nextCategoryStarted,
  });

  int id;
  String name;
  int categoryId;
  dynamic childCategoryId;
  String description;
  double price;
  dynamic retailPrice;
  dynamic quantity;
  int statusId;
  List<dynamic> options;
  List<dynamic> images;
  dynamic thumbnail;
  int sortOrder;
  String marker;
  bool nextCategoryStarted;
}

class ItemImage {
  ItemImage({
    required this.id,
    required this.url,
    required this.itemId,
  });

  int id;
  String url;
  int itemId;

  factory ItemImage.fromJson(Map<String, dynamic> json) => ItemImage(
        id: json["id"],
        url: json["url"],
        itemId: json["itemId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "itemId": itemId,
      };
}

class Option {
  Option({
    required this.id,
    required this.name,
    required this.group,
    required this.itemId,
    required this.quantity,
    required this.price,
    required this.image,
    required this.iconImage,
    required this.supplierVariantCode,
  });

  int id;
  String name;
  String group;
  int itemId;
  int quantity;
  dynamic price;
  dynamic image;
  dynamic iconImage;
  String supplierVariantCode;
}
