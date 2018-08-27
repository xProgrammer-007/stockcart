import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stockcart/pages/cart_screen/cart_bloc.dart';
import 'package:stockcart/pages/cart_screen/cart_model.dart';
import 'package:stockcart/pages/item_detail/shop_item_model.dart';

class CardShopItem extends StatefulWidget {

  const CardShopItem({
    Key key,
    @required this.shopItem,
    @required this.document
  }) : super(key: key);

  final ShopItem shopItem;
  final DocumentSnapshot document;
  @override
  CardShopItemState createState() {
    return new CardShopItemState();
  }
}

class CardShopItemState extends State<CardShopItem> {

  bool addToFavs = false;

  _saveBtnTapped(CartBloc model,BuildContext context){

  setState(() {
    if (addToFavs == true) {
      model.removeSaveItem(widget.shopItem);
      addToFavs = false;
      Scaffold.of(context).showSnackBar(
          new SnackBar(
              content: new Text(
                  'Removed from wishlist'
              ),
              action: new SnackBarAction(label: 'UNDO', onPressed: () {
                addToFavs = false;
              })
          )
      );
    } else {
      model.saveItem(widget.shopItem);
      addToFavs = true;
      Scaffold.of(context).showSnackBar(
          new SnackBar(
              content: new Text(
                  'Added to wishlist'
              ),
              action: new SnackBarAction(
                  label: 'UNDO', onPressed: () {
                addToFavs = true;
              }
              )
          )
      );
    }
  });
}


  @override
  Widget build(BuildContext context) {
    final discountedPrice = int.parse(widget.shopItem.itemRate) - (int.parse(widget.shopItem.itemRate) * int.parse(widget.shopItem.salePercent) * 0.01);
    return ScopedModelDescendant<CartBloc>(
      rebuildOnChange: false,
      builder: (context,child,model){
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom:10.0),
                width:double.infinity,
                height: 150.0,
                child: FadeInImage(
                  image: NetworkImage(
                    widget.document['itemImageUrl'],
                  ),
                  fit: BoxFit.fitWidth,
                  placeholder: AssetImage('assets/image/placeholder_image.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:5.0),
                child: Text(
                  widget.document['itemName'].toString(),
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
                      '${widget.document['salePercent'].toString()}% off',
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
                Container(width:4.0),
                Text(
                  '${discountedPrice.round()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                ),Container(width:10.0),
                Image.asset(
                  'assets/image/rupee_normal.png',
                  color: Colors.black12,
                  height:10.0,
                ),
                Container(width:2.0),
                Text(
                  widget.shopItem.itemRate,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                      decoration: TextDecoration.lineThrough
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
                              _saveBtnTapped(model,context);
                            },
                            onLongPress: (){
                              model.removeAllSavedItems(context);
                            },
                            child:Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Icon(
                                    addToFavs ? Icons.favorite : Icons.favorite_border,
                                    color:Colors.red,
                                    size:30.0
                                )
                            )
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
