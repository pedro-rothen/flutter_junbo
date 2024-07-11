import 'package:flutter_junbo/data/datasources/products/product_remote_data_source.dart';
import 'package:flutter_junbo/domain/entities/product.dart';
import 'package:flutter_junbo/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl({required this.productRemoteDataSource});

  @override
  Future<List<Product>> getProducts() {
    return productRemoteDataSource.getProducts();
  }
}