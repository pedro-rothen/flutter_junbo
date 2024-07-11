import 'package:flutter_junbo/domain/entities/product.dart';
import 'package:flutter_junbo/domain/repositories/product_repository.dart';
import 'package:flutter_junbo/domain/usecases/products/get_products_use_case.dart';

class GetProductsUseCaseImpl implements GetProductsUseCase {
  final ProductRepository productRepository;

  GetProductsUseCaseImpl({required this.productRepository});

  @override
  Future<List<Product>> execute() {
    return productRepository.getProducts();
  }
}