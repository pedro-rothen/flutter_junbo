import 'package:flutter_junbo/data/datasources/products/product_remote_data_source.dart';
import 'package:flutter_junbo/domain/entities/product.dart';
import 'package:uuid/uuid.dart';

class MockProductRemoteDataSource implements ProductRemoteDataSource {
  @override
  Future<List<Product>> getProducts() async {
    return [
      _mockProduct(name: "Pan francés", imageId: "333213a", price: 100),
      _mockProduct(name: "Hallulla", imageId: "701367a", price: 100),
      _mockProduct(name: "Pan Amasado", imageId: "330660a", price: 100),
      _mockProduct(name: "Pan Dobladas", imageId: "295859a", price: 100),
      _mockProduct(name: "Pan de Molde", imageId: "1017777a", price: 100),
    ];
  }

  Product _mockProduct({required String name, required String imageId, required double price}) {
    return Product(
        id: const Uuid().v4(),
        name: name,
        image: "https://images.lider.cl/wmtcl?source=url[file:/productos/$imageId.jpg]&scale=size[180x180]&sink",
        price: price
    );
  }
}