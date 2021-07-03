
// TODO Implement geohasing
class Shop {

  final String name;
  final String imageUrl;
  final double rating;
  final String categoryId;

  Shop({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.categoryId,
  });

  Shop.fromMap(Map<String, dynamic> map) :
    this.name = map['name'],
    this.imageUrl = map['imageUrl'],
    this.rating = map['rating'],
    this.categoryId = map['categoryId'];

  Map<String, dynamic> toMap() => {
    'name' : this.name,
    'imageUrl' : this.imageUrl,
    'rating' : this.rating,
    'categoryId' : this.categoryId,

  };

}