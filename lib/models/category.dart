class Category {

  final String name;
  final String imageUrl;

  Category({
    required this.name,
    required this.imageUrl,
  });

  Category.fromMap(Map<String, dynamic> map)
    : this.name = map['name'],
      this.imageUrl = map['imageUrl'];

  Map<String, dynamic> toMap() {
    return {
      'name' : this.name,
      'imageUrl' : this.imageUrl
    };
  }

}