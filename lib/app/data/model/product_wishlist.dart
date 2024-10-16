class ProductWishList {
  String? image; // Remove final
  String? title;
  String?subtitle;
  String? price;
  String? kategorie1;
  int count;
  int? id;
  String? imageUrl;

  ProductWishList({
    this.image,
    this.title,
    this.subtitle,
    this.price,
    this.count = 1,
    this.kategorie1,
    this.id,
    this.imageUrl,
  });
}

