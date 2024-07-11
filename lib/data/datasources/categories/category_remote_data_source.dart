import 'package:flutter_junbo/domain/entities/category.dart';

abstract class CategoryRemoteDataSource {
  Future<List<Category>> getCategories();
}