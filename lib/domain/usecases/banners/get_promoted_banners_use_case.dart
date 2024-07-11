import 'package:flutter_junbo/domain/entities/banner.dart';

abstract class GetPromotedBannersUseCase {
  Future<List<Banner>> execute();
}