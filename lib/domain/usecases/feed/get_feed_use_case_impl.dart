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
    await Future.delayed(const Duration(seconds: 2));
    //Could be this function mapped into a pipeline with Stream(?)
    List<FeedEntry> feed = [];
    final categories = await getCategoriesUseCase.execute();
    final products = await getProductsUseCase.execute();
    //final promotedBanners = await getPromotedBannersUseCase.execute();
    final banners = await getBannersUseCase.execute();
    for (var category in categories) {
      final List<Product> shuffledProducts = List.from(products)..shuffle();
      feed.add(
          FeedEntry(
              type: FeedEntryType.products,
              value: ProductsCategory(
                  category: category, products: shuffledProducts
              )
          )
      );
    }
    for (var banner in banners) {
      feed.add(FeedEntry(type: FeedEntryType.singleBanner, value: banner));
    }
    final List<FeedEntry> shuffledFeed = List.from(feed)..shuffle();
    shuffledFeed.insert(0, FeedEntry(type: FeedEntryType.categories, value: categories));
    return shuffledFeed;
  }
}