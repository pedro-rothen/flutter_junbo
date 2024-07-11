import 'package:flutter_junbo/domain/entities/category.dart';

abstract class GetCategoriesUseCase {
  Future<List<Category>> execute();
}