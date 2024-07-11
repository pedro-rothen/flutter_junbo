import 'package:flutter_junbo/domain/entities/banner.dart';
import 'package:flutter_junbo/domain/repositories/banner_repository.dart';
import 'package:flutter_junbo/domain/usecases/banners/get_promoted_banners_use_case.dart';

class GetPromotedBannersUseCaseImpl implements GetPromotedBannersUseCase {
  final BannerRepository bannerRepository;

  GetPromotedBannersUseCaseImpl({required this.bannerRepository});

  @override
  Future<List<Banner>> execute() {
    return bannerRepository.getPromotedBanners();
  }
}