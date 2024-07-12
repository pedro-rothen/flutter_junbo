import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_junbo/domain/usecases/feed/get_feed_use_case.dart';
import 'package:flutter_junbo/domain/entities/feed_entry.dart';

abstract class MainEvent {}
class LoadFeedEvent extends MainEvent {}

abstract class MainState {}
class MainLoadingState extends MainState {}
class MainErrorState extends MainState {}
class MainSuccessState extends MainState {
  final List<FeedEntry> feed;

  MainSuccessState({required this.feed});
}

/*
Not supported for bloc v8 yield async*
 enum MainState {
  initial, loading, error, success
}*/

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetFeedUseCase getFeedUseCase;

  MainBloc({required this.getFeedUseCase}) : super(MainLoadingState()) {
    on<LoadFeedEvent>(_getFeed);
  }

  Future<void> _getFeed(LoadFeedEvent event, Emitter<MainState> emit) async {
    emit(MainLoadingState());
    await getFeedUseCase
        .execute()
        .then((feed) {
          emit(MainSuccessState(feed: feed));
        })
        .catchError((error) {
          print(error);
          emit(MainErrorState());
        });
  }
}