//Designs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stockcart/pages/cart_screen/cart_model.dart';
import 'package:stockcart/pages/item_detail/index.dart';

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

  ClothingType _decideClothingType(clothingType){
   ClothingType type;
   print(clothingType.toString());
    switch(clothingType.toString()){
     case 'ClothingType.jeans':
       type = ClothingType.jeans;
       break;
      case 'ClothingType.shirt':
        type = ClothingType.shirt;
        break;
      case 'ClothingType.tee_shirt':
        type = ClothingType.tee_shirt;
        break;
      case 'ClothingType.shoes':
        type = ClothingType.shoes;
        break;
      default: type = ClothingType.none;
   }
   return type;
  }

 List<int> _numberSizeMaker(List sizes){
      return sizes.map((size){
        return int.parse(size.toString());
      }).toList();
  }

  List<ShirtSizeType>_shirtSizeMaker(List sizes){
    return sizes.map((size){
      ShirtSizeType type;
      switch(size.toString()){
        case 'ShirtSizeType.xs':
          type = ShirtSizeType.xs;
          break;
        case 'ShirtSizeType.s':
          type = ShirtSizeType.s;
          break;
        case 'ShirtSizeType.m':
          type = ShirtSizeType.m;
          break;
        case 'ShirtSizeType.lg':
          type = ShirtSizeType.lg;
          break;
        case 'ShirtSizeType.xl':
          type = ShirtSizeType.xl;
          break;
        case 'ShirtSizeType.xxl':
          type = ShirtSizeType.xxl;
          break;
        default: type = ShirtSizeType.none;
      }
      return type;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
               final clothingType = _decideClothingType(document['clothingType']);

               return Container(
                 width: double.infinity,
                 child: GestureDetector(
                   onTap: (){
                     Navigator.push(context,MaterialPageRoute(
                         builder: (BuildContext context) => new CartItemDetails(
                           shopItem: new ShopItem(
                             images: (document['images'] as List)
                                 .map((f)=>f.toString()).toList().cast<String>().toList(),
                             salePercent: document['salePercent'].toString(),
                             itemRate: document['itemRate'].toString(),
                             itemName: document['itemName'].toString(),
                             clothingType:clothingType,
                             subTitle: document['subTitle'].toString(),
                             colorChoices: (document['colorChoices'] as List).map((hexColor){
                               return new CustomColor(
                                   name: 'Chewla ',
                                   colorHex:hexColor.toUpperCase()
                               );
                             }).toList(),
                             jeansSizeTypes: clothingType == ClothingType.jeans
                                 ? _numberSizeMaker((document['jeansSizeTypes'] != null ? document['jeansSizeTypes'] : const [] as List).cast<String>().toList())
                                 : null,
                             shirtSizeTypes: clothingType == ClothingType.shirt
                                 ? _shirtSizeMaker((document['shirtSizeTypes'] as List).cast<String>().toList())
                                 : null,
                             sellerContact: document['sellerContact'].toString(),
                             about: document['about'].toString(),
                           ),
                         )
                     ));
                   },
                   child: Card(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Container(
                           padding: EdgeInsets.only(bottom:10.0),
                           width:double.infinity,
                           height: 150.0,
                           child: FadeInImage(
                             image: NetworkImage(
                               document['itemImageUrl'],
                             ),
                             fit: BoxFit.cover,
                             placeholder: AssetImage('assets/image/placeholder_image.png'),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal:5.0),
                           child: Text(
                             document['itemName'].toString(),
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal:5.0),
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: <Widget>[
                               Container(
                                 margin: EdgeInsets.only(top:5.0),
                                 height:20.0,
                                 child: Stack(
                                   children: <Widget>[
                                     Image.asset(
                                       'assets/image/new_icon.png',
                                       fit: BoxFit.cover,
                                     ),
                                   ],
                                 ),
                               ),
                               Container(width:10.0),
                               Text(
                                 '${document['salePercent'].toString()}% off',
                                 style: TextStyle(
                                   color: Colors.green,
                                   fontFamily: 'JosefinSans',
                                   fontSize: 16.0,
                                   fontStyle: FontStyle.italic,
                                   decorationStyle: TextDecorationStyle.dashed
                                 ),
                               )
                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(top:10.0,left:5.0,right:5.0),
                           child: Row(
                             children: <Widget>[
                               Image.asset(
                                 'assets/image/rupee_normal.png',
                                 color: Colors.orangeAccent,
                                 height:15.0,
                               ),
                               Text(
                                 document['itemRate'].toString(),
                                 style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   color: Colors.deepOrangeAccent,
                                 ),
                               ),
                               Expanded(child: Container(),),
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal:5.0,vertical:1.0),
                                 child: Material(
                                   borderRadius: BorderRadius.circular(15.0),
                                   color: Colors.transparent,
                                   child: InkWell(
                                     onTap: (){

                                     },
                                     child:Container(
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(15.0),
                                         ),
                                         child: Icon(Icons.favorite_border,color:Colors.red,size:30.0))
                                   ),
                                 ),
                               )
                             ],
                           ),
                         )
                       ],
                     ),
                   ),
                 ),
               );
             },childCount: itemCount),
           );
         },
        ),
      ],
    );
  }
}
