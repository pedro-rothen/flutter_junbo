import 'package:flutter_junbo/data/datasources/categories/category_remote_data_source.dart';
import 'package:flutter_junbo/domain/entities/category.dart';
import 'package:flutter_junbo/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl({required this.categoryRemoteDataSource});

  @override
  Future<List<Category>> getCategories() {
    return categoryRemoteDataSource.getCategories();
  }
}