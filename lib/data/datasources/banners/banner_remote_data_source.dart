import 'package:flutter_junbo/domain/entities/banner.dart';

abstract class BannerRemoteDataSource {
  Future<List<AppBanner>> getPromotedBanners();
  Future<List<AppBanner>> getBanners();
}