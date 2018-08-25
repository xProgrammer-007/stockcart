
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stockcart/pages/cart_screen/cart_bloc.dart';

class CartItem extends StatefulWidget {

  final String networkImagePath;
  final String itemName;
  final String rate;
  final Color selectedColor;
  final String size;
  final int itemCount;
  final Function onDeletePressed;
  final int itemIndex;
  final Function onAddPressed;
  final Function onSubtractPressed;
  final String subTitle;
  final int salePercent;


  CartItem({
    Key key,
    this.rate,
    this.itemIndex,
    this.onAddPressed,
    this.onDeletePressed,
    this.onSubtractPressed,
    this.itemName = '',
    this.networkImagePath = '',
    this.itemCount,
    this.selectedColor = Colors.white,
    this.size = '',
    this.subTitle = '',
    this.salePercent = 0
  }) : super(key: key);




  @override
  CartItemState createState() {
    return new CartItemState();
  }
}

class CartItemState extends State<CartItem> {


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartBloc>(
      builder: (context,child,model){
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                elevation: 4.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title:Text(
                        widget.itemName,
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 16.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(height:5.0),
                          Text(
                            '${widget.subTitle}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black45
                            ),
                          ),

                          Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child:Row(
                                  children:[
                                    Image.asset(
                                      'assets/image/rupee_normal.png',
                                      color: Colors.deepOrange,
                                      width: 10.0,
                                      height: 20.0,
                                    ),
                                    Container(width:10.0),
                                    Text(
                                      '${widget.rate.toString()}'.toUpperCase(),
                                      style: TextStyle(
                                          fontFamily: 'JosefinSans',
                                          fontWeight:FontWeight.w500,
                                          fontSize: 24.0,
                                          color: Colors.deepOrange
                                      ),
                                    ),
                                    Container(width:10.0),
                                    Text(
                                      '${widget.salePercent.toString()} % off'.toUpperCase(),
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontWeight:FontWeight.w500,
                                          fontSize: 13.0,
                                          color: Colors.green
                                      ),
                                    ),
                                  ]
                              )
                          ),
                        ],
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new CachedNetworkImage(
                          height: 100.0,
                          width: 100.0,
                          fit: BoxFit.cover,
                          imageUrl: widget.networkImagePath,
                          placeholder: new CircularProgressIndicator(),
                          errorWidget: new Icon(Icons.error),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:15.0,top:20.0),
                      padding: const EdgeInsets.symmetric(vertical:10.0,horizontal:8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width:20.0,
                            height:20.0,
                            decoration: BoxDecoration(
                              color: widget.selectedColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: 1==1 ? Container() : Text(
                                'Navy Blue',
                                style: TextStyle(
                                    fontFamily: 'OpenSans'
                                ),
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Text(
                              'Size : ${widget.size}',
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: (){
                              widget.onDeletePressed(widget.itemIndex);
                            },
                            icon: Icon(Icons.delete,color: Colors.black38,),
                          ),
                          Expanded(child: Container(),),
                          Container(
                            width:50.0,
                            child: FlatButton(
                              child: Icon(Icons.remove_circle_outline,color: Colors.grey,),
                              onPressed: (){
                                widget.onSubtractPressed(widget.itemIndex);
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color:Colors.deepOrange,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '${widget.itemCount}',
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontFamily: 'OpenSans',
                                        fontSize: 14.0
                                    ),
                                  )
                                  ,Container(
                                    margin: EdgeInsets.only(left:10.0),
                                    width:1.5,
                                    height:25.0,
                                    color:Colors.deepOrange,
                                  ),
                                  FlatButton(
                                    onPressed: (){
                                      widget.onAddPressed(widget.itemIndex);
                                    },
                                    child: Text(
                                      '+ Add',
                                      style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontFamily: 'OpenSans',
                                          fontSize: 14.0
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
            ),
          ),
        );
      },
    );
  }
}
