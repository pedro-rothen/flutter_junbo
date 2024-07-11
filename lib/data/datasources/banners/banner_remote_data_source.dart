import 'package:flutter_junbo/domain/entities/banner.dart';

abstract class BannerRemoteDataSource {
  Future<List<Banner>> getPromotedBanners();
  Future<List<Banner>> getBanners();
}