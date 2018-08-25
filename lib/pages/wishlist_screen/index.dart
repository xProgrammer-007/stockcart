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
          ScopedModelDescendant<CartBloc>(
            builder: (context,child,model){
               model.getStoredItems();
              return new StreamBuilder(
                stream: model.savedData.asBroadcastStream(),
                builder: (BuildContext context , AsyncSnapshot<List<ShopItem>> snapshot){
                  return new ListView.builder(
                    itemCount:snapshot.hasData ? snapshot.data.length : 0,
                    itemBuilder: (BuildContext context , int i){
                      return new Text('$i');
                   },
                  );
                },
              );
            },
          )
        ],
      )
    );
  }


}
