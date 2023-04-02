class Book {
  String id;
  String user;
  String key;
  double price;
  String? title;
  String? coverUrl;

  Book({required this.id, required this.user, required this.key, required this.price, this.title, this.coverUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['_id'],
      user: json['user'],
      key: json['key'],
      price: json['price'],
      title: json['title'],
      coverUrl: json['coverUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['user'] = this.user;
    data['key'] = this.key;
    data['price'] = this.price;
    data['title'] = this.title;
    data['coverUrl'] = this.coverUrl;
    return data;
  }
}
