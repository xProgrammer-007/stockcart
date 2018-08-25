//Designs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stockcart/pages/cart_screen/cart_bloc.dart';
import 'package:stockcart/pages/cart_screen/cart_model.dart';
import 'package:stockcart/pages/home_screen/shop_item_card.dart';
import 'package:stockcart/pages/item_detail/index.dart';
import 'package:sembast/sembast.dart';
import 'package:stockcart/pages/item_detail/shop_item_model.dart';

class HomeScreenIndexPage extends StatelessWidget {

  final Firestore firestore;

  HomeScreenIndexPage(this.firestore);

  final loading = SliverList(
    delegate: SliverChildListDelegate(
        [
          Center(
            child: CircularProgressIndicator(),
          )
        ]
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: FadeInImage(
                placeholder: NetworkImage(
                  'http://www.machovibes.com/wp-content/uploads/2017/12/All-Time-Best-Formal-Outfits-For-Men-feature.jpg',
                ),
                fit: BoxFit.cover,
                image:NetworkImage('')
              ),

              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '40%',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    'on sale'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: 20.0,
                )
              ]
            ),
          ),
         StreamBuilder<QuerySnapshot>(
           stream: firestore.collection('cart').snapshots(),
           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
             if(!snapshot.hasData) {

               print('no Data snapshot');
               return loading;
             }

             final int itemCount = snapshot.data.documents.length;

             return new SliverGrid(
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   crossAxisSpacing: 1.0,
                   childAspectRatio: 0.7,
                   mainAxisSpacing: 2.0
               ),
               delegate: SliverChildBuilderDelegate((BuildContext context , int i){
                 final DocumentSnapshot document = snapshot.data.documents[i];
                  print(document);

                 ShopItem shopItem = new ShopItem.fromDocumentSnapshot(document);
                 return Container(
                   width: double.infinity,
                   child: GestureDetector(
                     onTap: (){
                       Navigator.push(context,MaterialPageRoute(
                           builder: (BuildContext context) => new CartItemDetails(
                             shopItem: shopItem
                           )
                       ));
                     },
                     child: new CardShopItem(
                       shopItem: shopItem,
                       document: document
                     ),
                   ),
                 );
               },childCount: itemCount),
             );
           },
          ),
        ],
      ),
    );
  }
}

