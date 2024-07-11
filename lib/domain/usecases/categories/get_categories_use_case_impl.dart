import 'package:flutter_junbo/domain/entities/category.dart';
import 'package:flutter_junbo/domain/repositories/category_repository.dart';
import 'package:flutter_junbo/domain/usecases/categories/get_categories_use_case.dart';

class GetCategoriesUseCaseImpl implements GetCategoriesUseCase {
  final CategoryRepository categoryRepository;

  GetCategoriesUseCaseImpl({required this.categoryRepository});

  @override
  Future<List<Category>> execute() {
    return categoryRepository.getCategories();
  }
}