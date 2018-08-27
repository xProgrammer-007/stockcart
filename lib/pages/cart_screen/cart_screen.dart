import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stockcart/components/customAppbar.dart';
import 'package:stockcart/pages/account_screen/account_bloc.dart';
import 'package:stockcart/pages/cart_screen/cart_bloc.dart';
import 'package:stockcart/pages/cart_screen/cart_item.dart';
import 'package:stockcart/pages/cart_screen/cart_model.dart';
import 'package:stockcart/pages/item_detail/sizeConverters.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartScreen extends StatefulWidget {
  @override
  CartScreenState createState() {
    return new CartScreenState();
  }
}

class CartScreenState extends State<CartScreen> {
String _sizeMaker(Cart cartItem){
   String size;
  switch(cartItem.clothingType){
      case ClothingType.jeans:
        size = cartItem.jeansSizeType.toString();
        break;
      case ClothingType.shirt:
        case ClothingType.tee_shirt:
          size = shirtSizeToString(cartItem.shirtSizeType);
        break;
      case ClothingType.none:  //Still gotta implement these but later on
      case ClothingType.shoes: //Still gotta implement these but later on
        size = "_sizeMaker(err)";
      break;

    }
    return size.toUpperCase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:100.0),
            child: ScopedModelDescendant<CartBloc>(

              builder: (context,child,model) =>
                  CustomScrollView(
                    slivers: <Widget>[
                      model.cartItems.length == 0
                          ? SliverList(
                          delegate:SliverChildListDelegate([
                            Padding(
                              padding: const EdgeInsets.only(top:30.0),
                              child: Center(
                                  child:Image.asset(
                                    'assets/image/empty-cart.png'
                                    ,fit: BoxFit.cover,
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Center(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.redAccent,
                                            spreadRadius: 5.0,
                                            blurRadius: 10.0,
                                            offset: Offset(0.0,10.0)
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(30.0)
                                  ),
                                  child: FlatButton(
                                    onPressed: (){

                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize:MainAxisSize.max,
                                        children: <Widget>[
                                          Text(
                                            'Go Shopping',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                fontFamily: 'OpenSans'
                                            ),
                                          ),
                                          Expanded(child: Container(),),
                                          Icon(Icons.chevron_right,color: Colors.white,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ])
                      ) :
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 20.0,
                            childAspectRatio: 1.6
                        ),
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context,int count){
                            return CartItem(
                              networkImagePath: model.cartItems[count].itemImageUrl,
                              rate: model.cartItems[count].itemRate,
                              itemName: model.cartItems[count].itemName,
                              selectedColor: model.cartItems[count].itemColor,
                              itemCount: model.cartItems[count].itemCount,
                              itemIndex: count,
                              size: _sizeMaker(model.cartItems[count]),
                              onAddPressed: (int index){
                                model.increaseCount(index);
                              },
                              subTitle: model.cartItems[count].subTitle,
                              salePercent: model.cartItems[count].salePercent,
                              onDeletePressed: (int index){
                                model.removeItem(index);
                              },
                              onSubtractPressed: (int index){
                                model.decreaseCount(index);
                              },
                            );
                          },
                          childCount: model.cartItems.length,
                        ),
                      ),
                      new CheckOutBtn(
                        model: model,
                      )
                    ],
                  ),
            ),
          ),

         new ScopedModelDescendant<AccountBloc>(
            builder:(context,child,model){
              return new PositionedAppbarCart(
                accountBloc: model,
              );
            }
          ),
        ],
      ),
    );
  }
}

class CheckOutBtn extends StatelessWidget {
  final model;
  CheckOutBtn({
    this.model

  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
          [
            model.cartItems.length == 0 ? Container() : FlatButton(
              onPressed: (){},
              child: Container(
                  width: double.infinity,
                  height:50.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.red,Colors.orange,Colors.redAccent,Colors.deepOrange,],
                        begin: FractionalOffset.centerLeft,
                        end: FractionalOffset.centerRight,
                        stops: [0.2,0.5,0.8,1.0]
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal:15.0,vertical:5.0),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: new Text('Checkout'.toUpperCase(),
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
            )
          ]
      ),
    );
  }
}

class PositionedAppbarCart extends StatelessWidget {
  final AccountBloc accountBloc;
  const PositionedAppbarCart({
    Key key,
   @required this.accountBloc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top:0.0,right:0.0,left:0.0,
      child: ScopedModelDescendant<CartBloc>(
        builder: (context,child,model){

          _calculateTotal(){
              int price = 0;
              model.cartItems.map((item){
                price+= int.parse(item.itemRate) * (item.itemCount != null && item.itemCount > 0 ? item.itemCount : 0);
              }).toString();
              return price;
          }

          return AppBarCustomCurved(
            showActions: true,
            showLeading: false,
            actions: <Widget>[
              new StreamBuilder(
                stream: accountBloc.userData.asBroadcastStream(),
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
            height:110.0,
            title: Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontWeight:FontWeight.w500,
                        fontSize: 20.0,
                        color: Colors.white,
                        decorationStyle: TextDecorationStyle.dashed
                    ),
                  ),
                  Container(width:10.0,color:Colors.white),
                  Image.asset(
                    'assets/image/rupee_normal.png',
                    color: Colors.white,
                    width: 8.0,
                    height: 15.0,
                  ),
                  Container(width:5.0),
                  Text(
                   _calculateTotal().toString(),
                    style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontWeight:FontWeight.w500,
                        fontSize: 20.0,
                        color: Colors.white,
                        decorationStyle: TextDecorationStyle.dashed
                    ),
                  ),
                ],
              ),
            ),
            subtitle: Container(),
          );
        },
      ),
    );
  }
}

