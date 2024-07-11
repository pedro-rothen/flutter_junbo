import 'package:flutter_junbo/domain/entities/category.dart';
import 'package:flutter_junbo/domain/entities/product.dart';

class FeedEntry {
  final FeedEntryType type;
  final dynamic value;

  FeedEntry({required this.type, required this.value});
}

class ProductsCategory {
  final Category category;
  final List<Product> products;

  ProductsCategory({required this.category, required this.products});
}

enum FeedEntryType {
  categories,
  singleBanner,
  carrousselBanner,
  products
}