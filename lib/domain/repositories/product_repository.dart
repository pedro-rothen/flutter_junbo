import 'package:flutter_junbo/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}