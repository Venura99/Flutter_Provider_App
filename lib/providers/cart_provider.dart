import 'package:flutter/material.dart';
import 'package:provider_flutter/models/cart_model.dart';

class CartProvider extends ChangeNotifier{

  // cart items state
  Map<String, CartItem> _items = {};

  //getter
  Map<String , CartItem> get items {
    return {..._items};
  }

  //add item
  void addItem(String productId, double price, String title){
    if(_items.containsKey(productId)){
      _items.update(
        productId, 
        (existingCartItem)=> CartItem(
        id: existingCartItem.id, 
        title: existingCartItem.title, 
        price: existingCartItem.price, 
        quantity: existingCartItem.quantity + 1,
        )
      );
      print("add data");
    }else{
      _items.putIfAbsent(productId, () => CartItem(
        id: productId, 
        title: title, 
        price: price, 
        quantity: 1)); 
    }
    notifyListeners();
  }

  //remove from cart
  void removeItem (String productId){
    _items.remove(productId);
    notifyListeners();
  }

  //remove single item from cart

  void removeSingleItem(String productId){
    if(!_items.containsKey(productId)){
      return;
    }
    if(_items[productId]!.quantity > 1){
      _items.update(productId, (existingCartItem) => 
        CartItem(
          id: existingCartItem.id, 
          title: existingCartItem.title, 
          price: existingCartItem.price, 
          quantity: existingCartItem.quantity - 1,
          ),
          );
    }
    else{
      _items.remove(productId);
    }
    notifyListeners();
  }
}