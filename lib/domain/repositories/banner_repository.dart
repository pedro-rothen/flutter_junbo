import 'package:flutter_junbo/domain/entities/banner.dart';

abstract class BannerRepository {
  Future<List<AppBanner>> getBanners();
  Future<List<AppBanner>> getPromotedBanners();
}