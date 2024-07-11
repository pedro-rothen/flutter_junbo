import 'package:flutter_junbo/domain/entities/banner.dart';
import 'package:flutter_junbo/domain/repositories/banner_repository.dart';
import 'package:flutter_junbo/domain/usecases/banners/get_banners_use_case.dart';

class GetBannersUseCaseImpl implements GetBannersUseCase {
  final BannerRepository bannerRepository;

  GetBannersUseCaseImpl({required this.bannerRepository});

  @override
  Future<List<Banner>> execute() {
    return bannerRepository.getBanners();
  }
}