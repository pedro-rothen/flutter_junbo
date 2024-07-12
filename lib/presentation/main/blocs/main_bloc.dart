import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_junbo/domain/entities/cart_item.dart';
import 'package:flutter_junbo/domain/entities/product.dart';
import 'package:flutter_junbo/domain/usecases/feed/get_feed_use_case.dart';
import 'package:flutter_junbo/domain/entities/feed_entry.dart';

abstract class MainEvent {}
class LoadFeedEvent extends MainEvent {}
class ModifyCartEvent extends MainEvent {
  final Product product;

  ModifyCartEvent({required this.product});
}
class AddProductUnitEvent extends ModifyCartEvent {
  AddProductUnitEvent({required super.product});
}
class RemoveProductUnitEvent extends ModifyCartEvent {
  RemoveProductUnitEvent({required super.product});
}

class CartInfo {
  final int productsQuantity;
  final double total;

  CartInfo({required this.productsQuantity, required this.total});
}

abstract class MainState {}
class MainLoadingState extends MainState {}
class MainErrorState extends MainState {}
class MainLoadedState extends MainState {
  final List<FeedEntry> feed;
  final List<CartItem>? cartItems;
  final CartInfo? cartInfo;

  MainLoadedState({required this.feed, this.cartItems, this.cartInfo});
}

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetFeedUseCase getFeedUseCase;
  //Running out of time, imagine that I have a GetCartUseCase, AddProductUnitToCartUseCase and a RemoveProductUnitFromCartUseCase
  //GetCartUseCase: From a repository gets a instance of List<CartItem>, data source could be in memory, local or remote
  //AddProductUnitToCartUseCase: Adds a unit of the specified product, UseCase figures how to add it
  //RemoveProductUnitFromCartUseCase: Removes a unit of the specified product, UseCase figures how to remove it
  //To skip integration just gonna leave here a in memory cart. "Add" and "remove" would be handled bellow
  final List<CartItem> _cartItems = List.empty(growable: true);
  List<FeedEntry> _feed = List.empty();

  MainBloc({required this.getFeedUseCase}) : super(MainLoadingState()) {
    on<LoadFeedEvent>(_getFeed);
    on<AddProductUnitEvent>(_addUnit);
    on<RemoveProductUnitEvent>(_removeUnit);
  }

  Future<void> _getFeed(LoadFeedEvent event, Emitter<MainState> emit) async {
    emit(MainLoadingState());
    await getFeedUseCase
        .execute()
        .then((feed) {
          _feed = feed;
          emit(MainLoadedState(feed: _feed));
        })
        .catchError((error) {
          emit(MainErrorState());
        });
  }

  void _addUnit(AddProductUnitEvent event, Emitter<MainState> emit) {
    //AddProductUnitToCartUseCase would be called here in a async context
    final product = event.product;
    final index = _cartItems.indexWhere((cartItem) => cartItem.product.id == product.id);
    if (index != -1) {
      _cartItems[index].quantity += 1;
    } else {
      _cartItems.add(CartItem(product: product, quantity: 1));
    }
    emit(MainLoadedState(feed: _feed, cartItems: _cartItems, cartInfo: _builtCartInfo()));
  }

  void _removeUnit(RemoveProductUnitEvent event, Emitter<MainState> emit) {
    //RemoveProductUnitFromCartUseCase would be called here in a async context
    final product = event.product;
    final index = _cartItems.indexWhere((cartItem) => cartItem.product.id == product.id);
    if (index != -1) {
      final cartItem = _cartItems[index];
      if (cartItem.quantity == 1) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity -= 1;
      }
    }
    emit(MainLoadedState(feed: _feed, cartItems: _cartItems, cartInfo: _builtCartInfo()));
  }

  CartInfo? _builtCartInfo() {
    if (_cartItems.isNotEmpty) {
      return CartInfo(productsQuantity: _cartItems.length, total: _calculateTotal());
    }
    return null;
  }

  double _calculateTotal() {
    return _cartItems.fold(0, (total, element) => total + element.quantity * element.product.price);
  }

  /*int _quantityOf({required Product product}) {
    final index = _cartItems.indexWhere((cartItem) => cartItem.product.id == product.id);
    if (index != 1) {
      return _cartItems[index].quantity;
    } else {
      return 0;
    }
  }*/
}