

class Product_List {
  String? image;
  String? imageUrl; // Remove final
  String? name;
  String? price;
  String? point;
  String? kategorie1;
  int? id;
  int? rating;
  int? review;


  Product_List({
    this.image,
    this.imageUrl,
    this.kategorie1,
    this.id,
    this.name,
    this.price,
    this.point,
    this.rating,
    this.review
  });
}

class Review_List {
  int? id;
  double? rating;
  String? reviewComment;
  String? productId;
  String? userId;
  String? userName;
  String? showStatus;
  String? createdAt;
  String? updatedAt;
  String? profilePicture;

  Review_List({
    this.id,
    this.rating,
    this.reviewComment,
    this.productId,
    this.userId,
    this.userName,
    this.showStatus,
    this.createdAt,
    this.updatedAt,
    this.profilePicture,
  });
}

