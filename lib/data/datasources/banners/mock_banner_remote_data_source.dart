import 'dart:math';

import 'package:flutter_junbo/data/datasources/banners/banner_remote_data_source.dart';
import 'package:flutter_junbo/domain/entities/banner.dart';
import 'package:uuid/uuid.dart';

class MockBannerRemoteDataSource implements BannerRemoteDataSource {
  @override
  Future<List<Banner>> getBanners() async {
    return [
      _mockBanner(name: "Recién llegados"),
      _mockBanner(name: "Para completos"),
      _mockBanner(name: "Para sándwich"),
      _mockBanner(name: "Para hamburguesa")
    ];
  }

  @override
  Future<List<Banner>> getPromotedBanners() async {
    final banners = await getBanners();
    final shuffled = banners;
    return shuffled.sublist(0, 3);
  }

  Banner _mockBanner({required String name}) {
    return Banner(id: const Uuid().v4(), name: name, color: PastelColor.random());
  }
}

extension PastelColor on String {
  static String random() {
    final random = Random();
    final colors = [
      "#b8dbd3",
      "#f7e7b4",
      "#68c4af",
      "#96ead7",
      "#f2f6c3"
    ];
    return colors[random.nextInt(colors.length)];
  }
}