import 'package:flutter/material.dart';

import 'cart_model.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

class CartBloc extends Model{
  List<Cart> cartItems;

  CartBloc(){
    print('xaxa init');
    this.cartItems = [
      new Cart(
        itemImageUrl: "https://teja8.kuikr.com/i4/20170214/100--original-Levi-s-mens-denim-jeans-wholesale-only-ak_LWBP1939213128-1487054856.jpeg",
        itemRate: '800',
        itemName: 'Blue jeans',
        itemColor: Colors.blue,
        itemCount: 1,

      ),
      new Cart(
        itemImageUrl: 'https://4.imimg.com/data4/FG/CC/MY-20902094/stylish-jeans-500x500.png',
        itemRate: '800',
        itemName: 'Blue jeans',
        itemColor: Colors.blue,
        itemCount: 1,
      ),
      new Cart(
        itemImageUrl: 'https://4.imimg.com/data4/FG/CC/MY-20902094/stylish-jeans-500x500.png',
        itemRate: '800',
        itemName: 'Blue jeans',
        itemColor: Colors.blue,
        itemCount: 1,
      )
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