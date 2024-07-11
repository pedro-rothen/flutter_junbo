import 'package:flutter_junbo/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
}