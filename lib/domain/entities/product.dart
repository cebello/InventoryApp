class Product {
  final int id;
  final String name;
  final String description;
  final int size;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.size,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    size: json['size'],
  );
}
