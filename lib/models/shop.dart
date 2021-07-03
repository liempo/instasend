import 'lat_lng.dart';

class Shop {

  final String name;
  final String imageUrl;
  final double rating;
  final String categoryId;
  final LatLng location;

  Shop({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.categoryId,
    required this.location
  });

  Shop.fromMap(Map<String, dynamic> map) :
    this.name = map['name'],
    this.imageUrl = map['imageUrl'],
    this.rating = map['rating'],
    this.categoryId = map['categoryId'],
    this.location = LatLng
      .fromGeoPoint(map['location']);

  Map<String, dynamic> toMap() => {
    'name' : this.name,
    'imageUrl' : this.imageUrl,
    'rating' : this.rating,
    'categoryId' : this.categoryId,
    'location' : this.location

  };

}