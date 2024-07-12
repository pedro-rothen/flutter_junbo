import 'package:flutter_junbo/data/datasources/banners/banner_remote_data_source.dart';
import 'package:flutter_junbo/domain/entities/banner.dart';
import 'package:flutter_junbo/domain/repositories/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource bannerRemoteDataSource;

  BannerRepositoryImpl({required this.bannerRemoteDataSource});

  @override
  Future<List<AppBanner>> getBanners() {
    return bannerRemoteDataSource.getBanners();
  }

  @override
  Future<List<AppBanner>> getPromotedBanners() {
    return bannerRemoteDataSource.getPromotedBanners();
  }
}