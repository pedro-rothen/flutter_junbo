import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_junbo/domain/entities/feed_entry.dart';
import 'package:flutter_junbo/presentation/main/blocs/main_bloc.dart';

class MainPage extends StatelessWidget {
  final MainBloc mainBloc;

  const MainPage({super.key, required this.mainBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => mainBloc..add(LoadFeedEvent()),
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ))
        ], backgroundColor: Theme.of(context).colorScheme.primary),
        body: BlocBuilder<MainBloc, MainState>(
          builder: (BuildContext context, MainState state) {
            if (state is MainLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MainSuccessState) {
              return ListView.builder(
                itemCount: state.feed.length,
                itemBuilder: (context, index) {
                  final feedEntry = state.feed[index];
                  switch(feedEntry.type) {
                    case FeedEntryType.categories:
                      return Text(feedEntry.type.name);
                    case FeedEntryType.products:
                      return Text(feedEntry.type.name);
                    case FeedEntryType.carrousselBanner:
                      return Text(feedEntry.type.name);
                    case FeedEntryType.singleBanner:
                      return Text(feedEntry.type.name);
                  }
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
