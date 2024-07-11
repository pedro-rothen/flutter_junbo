import 'package:flutter_junbo/domain/entities/banner.dart';

abstract class GetBannersUseCase {
  Future<List<Banner>> execute();
}