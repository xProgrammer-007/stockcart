import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sembast/sembast.dart';
import 'package:stockcart/pages/item_detail/shop_item_model.dart';

import 'cart_model.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

class CartBloc extends Model{
  final Database database;
  List<Cart> cartItems;
  BehaviorSubject<List<ShopItem>> savedData;

  CartBloc({this.database}) {
    //print('xaxa init');
    this.cartItems = [

    ];
    savedData = new BehaviorSubject<List<ShopItem>>(seedValue: const []);
    getStoredItems();
  }
  //List<Cart> get cartItems => _cartItems;

   increaseCount(int index) {
    // print(index);
    // print(cartItems[index].itemCount);
    cartItems[index].itemCount ++;
     //cartItems[index].itemCount < 999 ?  cartItems[index].itemCount++ : null;
    notifyListeners();
  }

  decreaseCount(int index) {

    cartItems[index].itemCount--;
    //print(index);
    //print(cartItems[index].itemCount);
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

  removeLast(){
    cartItems.removeLast();
    notifyListeners();
  }



  saveItem(ShopItem shopItem) async {
  //print(shopItem.toString());
  Store cartSavedStore = database.getStore("cartSaved");
    Record cartData = new Record(cartSavedStore,shopItem.toJson());
    await database.putRecords([cartData]);
    await cartSavedStore.records.listen((Record cart) {
      // here we know we have a single record
      // .. you'll get dog and cat here
      //print(cart);
    }).asFuture();
  }

  void getStoredItems() async{
    //print('axxa');
    savedData.add(
        await database.getStore("cartSaved").records.map((Record record){
         // print(record.value as Map);
          return new ShopItem.fromMap(record.value as Map ,record.key);
        }).toList()
    );
  }

  removeSaveItem(ShopItem shopItem) async{
    Store cartSavedStore = await database.getStore("cartSaved").store.delete(shopItem.recordKey);
  }
  
  removeAllSavedItems(BuildContext buildContext) async {
    showDialog(
      context: buildContext,
      builder: (BuildContext context){
        return new AlertDialog(
          title: Text('This action will clear your wishlist . Continue?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                bool deleteAction = await database.getStore("cartSaved").clear().then((_){
                  return true;
                }).catchError((Error err){
                  print(err);
                  return false;
                });
                Navigator.pop(buildContext);
                Scaffold.of(buildContext).showSnackBar(
                    new SnackBar(
                      content: new Text(
                          deleteAction ? 'Removed all items from wishlist' : 'Action unavailable , try again later'
                      ),
                    )
                );
              },
              child: Text('Yes'),
            ),
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('No'),
            )
          ],
        );
      }
    );
  }


}