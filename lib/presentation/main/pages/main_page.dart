import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_junbo/domain/entities/cart_item.dart';
import 'package:flutter_junbo/domain/entities/category.dart';
import 'package:flutter_junbo/domain/entities/feed_entry.dart';
import 'package:flutter_junbo/domain/entities/product.dart';
import 'package:flutter_junbo/domain/entities/banner.dart';
import 'package:flutter_junbo/presentation/main/blocs/main_bloc.dart';

class MainPage extends StatelessWidget {
  final MainBloc mainBloc;

  const MainPage({super.key, required this.mainBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => mainBloc..add(LoadFeedEvent()),
      child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            List<Widget> actions = List.empty(growable: true);
            if (state is MainLoadedState) {
              final cartInfo = state.cartInfo;
              if (cartInfo != null) {
                actions.add(Text("(${cartInfo.productsQuantity}) \$${cartInfo.total}"));
              }
            }
            actions.add(
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ))
            );
            return Scaffold(
              appBar: AppBar(
                  actions: actions,
                  backgroundColor: Theme.of(context).colorScheme.primary
              ),
              body: const FeedWidget(),
            );
          }
      ),
    );
  }
}


class FeedWidget extends StatelessWidget {
  const FeedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(builder: (context, state) {
      if (state is MainLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is MainLoadedState) {
        return ListView.builder(
          itemCount: state.feed.length,
          itemBuilder: (context, index) {
            final feedEntry = state.feed[index];
            switch(feedEntry.type) {
              case FeedEntryType.categories:
                final categories = feedEntry.value as List<Category>;
                return CategoriesRowWidget(categories: categories);
              case FeedEntryType.products:
                final productsCategory = feedEntry.value as ProductsCategory;
                return ProductsRowWidget(productsCategory: productsCategory);
              case FeedEntryType.carrousselBanner:
                return Text(feedEntry.type.name);
              case FeedEntryType.singleBanner:
                final banner = feedEntry.value as AppBanner;
                return SizedBox(
                    height: 150,
                    child: Container(
                      alignment: Alignment.center,
                      color: hexToColor(banner.color),
                      child: Text(banner.name)
                    ));
            }
          },
        );
      }
      return Container();
    });
  }
}

class CategoriesRowWidget extends StatelessWidget {
  final List<Category> categories;

  const CategoriesRowWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                  width: 150,
                  height: 150,
                  alignment: Alignment.center,
                  color: hexToColor(category.color),
                  child: Text(category.name)
              );
            }));
  }
}

class ProductsRowWidget extends StatelessWidget {
  final ProductsCategory productsCategory;

  const ProductsRowWidget({super.key, required this.productsCategory});

  @override
  Widget build(BuildContext context) {
    final products = productsCategory.products;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(productsCategory.category.name),
      SizedBox(
          height: 300,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductItemWidget(product: products[index]);
              }
          ))
    ]);
  }
}

class ProductItemWidget extends StatelessWidget {
  final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      SizedBox(
          width: 150,
          height: 150,
          child: Image.network(product.image)
      ),
      Text("\$${product.price}"),
      Text("\$${product.name}"),
      const Text("1 un"),
          BlocBuilder<MainBloc, MainState>(builder: (context, state) {
            if (state is MainLoadedState) {
              final List<CartItem>? cartItems = state.cartItems;
              //Would like to keep some of this logic at some BLoc's method, but it may be a bad practice since we are responding to events (?)
              final index = cartItems?.indexWhere((cartItem) => cartItem.product.id == product.id);
              final productInCart = index != -1;
              if (productInCart) {
                final cartItem = cartItems?[index ?? 0];
                if (cartItem != null) {
                  return SizedBox(
                      height: 50,
                      child: Row(children: [
                        ElevatedButton(
                            onPressed: () {
                              context.read<MainBloc>().add(RemoveProductUnitEvent(product: product));
                            },
                            child: const Text("-")
                        ),
                        Text("${cartItem.quantity}"),
                        ElevatedButton(
                            onPressed: () {
                              context.read<MainBloc>().add(AddProductUnitEvent(product: product));
                            },
                            child: const Text("+")
                        )
                      ])
                  );
                }
              }
              return ElevatedButton(
                  onPressed: () {
                    context.read<MainBloc>().add(AddProductUnitEvent(product: product));
                  },
                  child: const Text("Agregar")
              );
            }
            return Container();
          })
    ]);
  }
}

Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write(alphaChannel);
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}