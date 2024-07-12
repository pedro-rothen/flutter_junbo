import 'package:flutter_junbo/data/datasources/banners/mock_banner_remote_data_source.dart';
import 'package:flutter_junbo/data/datasources/categories/category_remote_data_source.dart';
import 'package:flutter_junbo/domain/entities/category.dart';
import 'package:uuid/uuid.dart';

class MockCategoryRemoteDataSource implements CategoryRemoteDataSource {
  @override
  Future<List<Category>> getCategories() async {
    return [
      _mockCategory(name: "Pan molde"),
      _mockCategory(name: "Pan blanco"),
      _mockCategory(name: "Pan integral"),
      _mockCategory(name: "Pan envasado"),
      _mockCategory(name: "Pan congelado"),
      _mockCategory(name: "Pan importado")
    ];
  }

  Category _mockCategory({required String name}) {
    return Category(id: const Uuid().v4(), name: name, color: PastelColor.random());
  }
}