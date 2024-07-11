import 'package:flutter_junbo/domain/entities/product.dart';

class Category {
  final int id;
  final String name;
  final List<Product> products;

  Category({required this.id, required this.name, required this.products});
}