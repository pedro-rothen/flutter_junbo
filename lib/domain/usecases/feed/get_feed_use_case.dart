import 'package:flutter_junbo/domain/entities/feed_entry.dart';

abstract class GetFeedUseCase {
  Future<List<FeedEntry>> execute();
}