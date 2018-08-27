import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sembast/sembast.dart';
import 'package:stockcart/components/customAppbar.dart';
import 'package:stockcart/pages/account_screen/account_bloc.dart';
import 'package:stockcart/pages/cart_screen/cart_bloc.dart';
import 'package:stockcart/pages/cart_screen/cart_screen.dart';
import 'package:stockcart/pages/item_detail/shop_item_model.dart';
import 'package:stockcart/pages/wishlist_screen/wishlist_model.dart';

class WishlistIndexScreen extends StatefulWidget {

  final CartBloc model;
  WishlistIndexScreen({@required this.model});

  @override
  WishlistIndexScreenState createState() {
    return new WishlistIndexScreenState();
  }
}

class WishlistIndexScreenState extends State<WishlistIndexScreen> {

  @override
  void initState() {
    super.initState();
    widget.model.getStoredItems();
    widget.model.savedData.listen((List<dynamic> arr){
      print(arr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: <Widget>[
          ScopedModelDescendant<CartBloc>(
            builder: (context,child,model){
               model.getStoredItems();
              return Padding(
                padding: const EdgeInsets.only(top:118.0),
                child: new StreamBuilder(
                  stream: model.savedData.asBroadcastStream(),
                  builder: (BuildContext context , AsyncSnapshot<List<ShopItem>> snapshot){
                    if(!snapshot.hasData) return
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Center(
                                child: Image.asset('assets/image/wishlist.png',fit: BoxFit.cover,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:8.0),
                                child: Text(
                                  'No items to show'.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 25.0,
                                    fontFamily: 'JosefinSans'
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                    return new ListView.builder(
                      itemCount:snapshot.hasData ? snapshot.data.length : 0,
                      itemBuilder: (BuildContext context , int i){
                        final ShopItem shopItem = snapshot.data[i];
                        return new WishListItem(
                          image: shopItem.itemImageUrl == null ? shopItem.itemImageUrl : shopItem.images[0],
                          color: Colors.red,
                          showFilters: false,
                          title: shopItem.itemName,
                          shopItem: shopItem,
                          cartBloc: model,
                        );
                     },
                    );
                  },
                ),
              );
            },
          ),
          Positioned(
            top:0.0,
            left:0.0,
            right:0.0,
            child: new ScopedModelDescendant<AccountBloc>(
                builder:(context,child,model){
                  return AppBarCustomCurved(
                    showLeading: false,
                    showActions: true,
                    actions: <Widget>[
                      new StreamBuilder(
                        stream: model.userData.asBroadcastStream(),
                        builder: (BuildContext context, AsyncSnapshot<User> snapshot){
                          return new Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Material(
                                shape: new CircleBorder(),
                                child: snapshot.hasData && snapshot.data.photoUrl != null ? CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(snapshot.data?.photoUrl),
                                ) : Container()
                            ),
                          );
                        },
                      )
                    ],
                    height: 120.0,
                    title: Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Text(
                        'WISHLIST',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontFamily: 'JosefinSans'
                        ),
                      ),
                    ),
                    subtitle: Container(),
                  );
                }
            ),
          ),
        ],
      )
    );
  }


}


