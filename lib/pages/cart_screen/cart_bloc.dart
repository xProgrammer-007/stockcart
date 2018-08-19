import 'package:flutter/material.dart';

import 'cart_model.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

class CartBloc extends Model{
  List<Cart> cartItems;

  CartBloc(){
    print('xaxa init');
    this.cartItems = [

    ];
  }
  //List<Cart> get cartItems => _cartItems;

   increaseCount(int index) {
     print(index);
     print(cartItems[index].itemCount);
    cartItems[index].itemCount ++;
     //cartItems[index].itemCount < 999 ?  cartItems[index].itemCount++ : null;
    notifyListeners();
  }

  decreaseCount(int index) {

    cartItems[index].itemCount--;
    print(index);
    print(cartItems[index].itemCount);
    //cartItems[index].itemCount > 1 ?  cartItems[index].itemCount : null;
    notifyListeners();

  }

  addItem(Cart cartItem){
    cartItems.add(cartItem);
    notifyListeners();

  }

  removeItem(int index){
     print(index);
     cartItems.removeAt(index);
     notifyListeners();
  }






}