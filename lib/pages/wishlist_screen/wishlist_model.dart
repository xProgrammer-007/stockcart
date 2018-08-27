import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stockcart/pages/cart_screen/cart_bloc.dart';
import 'package:stockcart/pages/item_detail/shop_item_model.dart';

class WishListItem extends StatefulWidget {
  final String image;
  final bool showFilters;
  final ShopItem shopItem;
  final Color color;
  final String title;
  final CartBloc cartBloc;

  WishListItem({
    this.color,
    this.title,
    this.shopItem,
    this.image,
    this.showFilters,
    this.cartBloc
  });

  @override
  WishListItemState createState() {
    return new WishListItemState();
  }
}

class WishListItemState extends State<WishListItem> {

  @override
  Widget build(BuildContext context) {
    final discountedPrice = int.parse(widget.shopItem.itemRate) - (int.parse(widget.shopItem.itemRate) * int.parse(widget.shopItem.salePercent) * 0.01);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Card(
              elevation: 5.0,
              child: Container(
                height: 150.0,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: widget.image != null ? widget.image: 'https://www.rockymountainsearchacademy.com/wp-content/uploads/2012/08/bigstock-shopping-cart-icon-817929-300x300.jpg',
                      placeholder: Image.asset('assets/image/placeholder.jpg'),
                    ),
                    widget.showFilters
                        ? new Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: new BoxDecoration(
                        gradient: LinearGradient(
                            colors: [widget.color.withOpacity(0.3),Colors.white.withOpacity(0.2)],
                            begin: FractionalOffset.topRight,
                            end: FractionalOffset.bottomLeft,
                            stops: [0.5,1.0]
                        ),
                      ),
                    ): Container()

                  ],
                ),
              )
          ),

          Container(
            margin:EdgeInsets.only(top:180.0),
            padding: EdgeInsets.only(left:10.0,right: 10.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),Container(height:10.0),
                Row(
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
                      color: Colors.grey,
                      height:15.0,
                    ),
                    Container(width:4.0),
                    Text(
                      widget.shopItem.itemRate,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  ],
                ),
                Container(height: 10.0,)
              ],
            ),
          ),
          Positioned(
            bottom:55.0,
            right:22.0,
            child: new FloatingActionButton(
              elevation: 5.0,
              heroTag: null,
              backgroundColor:widget.showFilters ? widget.color : Colors.grey,
              onPressed: (){
                print('3434r4ewr');
                widget.cartBloc.removeSaveItem(widget.shopItem);
                Scaffold.of(context).showSnackBar(
                    new SnackBar(
                      content: new Text(
                          'Removed from wishlist'
                      ),
                    )
                );
              },
              child: Icon(Icons.delete,color: Colors.white,),
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child:  Transform(
              transform: Matrix4.translationValues(20.0, 130.0, 0.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.transparent,
                child: Ink(
                  child: InkWell(
                    onTap: (){
                      Navigator.push((context),new MaterialPageRoute(
                          builder: (BuildContext context){

                          }
                      ));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.redAccent,Color(0xFFff7346),Colors.red,Color(0xFFe91e63),],
                              begin: FractionalOffset.centerLeft,
                              end: FractionalOffset.centerRight,
                              stops: [0.2,0.5,0.8,1.0]
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal:15.0,vertical:10.0),

                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: new Text('More'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Lato',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Icon(Icons.chevron_right,color: Colors.white,),
                          ],
                        )
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
