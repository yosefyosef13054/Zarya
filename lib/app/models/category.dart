class Category {
  final int id;
  final String name;
  final String image;
  final int commissionMin;
  final int commissionDefault;
  final int commissionMax;
  final int statusId;
  final int parentId;
  final int sortOrder;

  Category({
    required this.commissionDefault,
    required this.commissionMax,
    required this.commissionMin,
    required this.id,
    required this.image,
    required this.name,
    required this.statusId,
    required this.parentId,
    required this.sortOrder,
  });
}
