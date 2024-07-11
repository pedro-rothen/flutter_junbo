import 'package:flutter_junbo/domain/entities/product.dart';

abstract class GetProductsUseCase {
  Future<List<Product>> execute();
}