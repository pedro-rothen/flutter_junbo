import 'package:flutter_junbo/domain/entities/category.dart';
import 'package:flutter_junbo/domain/entities/feed_entry.dart';
import 'package:flutter_junbo/domain/entities/product.dart';
import 'package:flutter_junbo/domain/usecases/banners/get_banners_use_case.dart';
import 'package:flutter_junbo/domain/usecases/banners/get_promoted_banners_use_case.dart';
import 'package:flutter_junbo/domain/usecases/categories/get_categories_use_case.dart';
import 'package:flutter_junbo/domain/usecases/feed/get_feed_use_case.dart';
import 'package:flutter_junbo/domain/usecases/products/get_products_use_case.dart';

class GetFeedUseCaseImpl implements GetFeedUseCase {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;
  final GetBannersUseCase getBannersUseCase;
  final GetPromotedBannersUseCase getPromotedBannersUseCase;

  GetFeedUseCaseImpl({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
    required this.getBannersUseCase,
    required this.getPromotedBannersUseCase
  });

  @override
  Future<List<FeedEntry>> execute() async {
    //Could be this function mapped into a pipeline with Stream(?)
    List<FeedEntry> feed = [];
    List<Category> categories = await getCategoriesUseCase.execute();
    List<Product> products = await getProductsUseCase.execute();
    feed.add(FeedEntry(type: FeedEntryType.categories, value: categories));
    for (var category in categories) {
      List<Product> shuffledProducts = products;
      shuffledProducts.shuffle();
      feed.add(
          FeedEntry(
              type: FeedEntryType.products,
              value: ProductsCategory(
                  category: category, products: shuffledProducts
              )
          )
      );
    }
    return feed;
  }
}