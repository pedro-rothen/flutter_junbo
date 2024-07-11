import 'package:flutter_junbo/domain/entities/banner.dart';

abstract class BannerRepository {
  Future<List<Banner>> getBanners();
  Future<List<Banner>> getPromotedBanners();
}