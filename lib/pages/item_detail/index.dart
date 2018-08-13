import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stockcart/pages/cart_screen/cart_bloc.dart';
import 'package:stockcart/pages/cart_screen/cart_model.dart';
import 'package:stockcart/pages/cart_screen/cart_screen.dart';
import 'package:stockcart/pages/item_detail/colorSelector.dart';
import 'package:stockcart/pages/item_detail/sizeConverters.dart';
import 'package:stockcart/pages/item_detail/sizeSelector.dart';


class ShopItem extends Cart{
  final List<String> images;
  final String subTitle;
  final int salePercent;
  final List<CustomColor> colorChoices;
  final List<ShirtSizeType> shirtSizeTypes;
  final List<JeansSizeType> jeansSizeTypes;
  final String about;
  final String sellerContact;

  ShopItem({
    this.images = const [],
    this.subTitle = '',
    this.colorChoices = const [],
    this.salePercent = 0,
    this.shirtSizeTypes = ShirtSizeType.values,
    this.jeansSizeTypes = JeansSizeType.values,
    this.about = '',
    this.sellerContact = '',
    itemName = '',
    clothingType = ClothingType.none,
    itemCount = 1,
    itemColor = Colors.white,
    itemImageUrl = '',
    itemRate = ''

  }){
    print(clothingType);
  }

}


class CartItemDetails extends StatelessWidget {
  Color blackCustom = Colors.black54;

  ShopItem shopItem;



  CartItemDetails({
    this.shopItem,
  });


  _applySize(size){
    if(shopItem.clothingType == ClothingType.jeans){
      shopItem.jeansSizeType = size;
    }else if(shopItem.clothingType == ClothingType.shirt) {
      shopItem.shirtSizeType = size;
    }else if(shopItem.clothingType == ClothingType.tee_shirt){
      shopItem.shirtSizeType = size;
    }else{
      print('_applySize Size clothing type mismatch');
      return 'mismatch';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                height: 250.0,
                child: Image.asset(shopItem.images[0],fit:BoxFit.cover),
              ),
              Container(
                transform: Matrix4.translationValues(100.0, -20.0, 0.0),
                  child:FloatingActionButton(
                    heroTag: 'asxax',
                    onPressed: (){},
                    child: Icon(Icons.favorite_border,),
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      shopItem.itemName.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight:FontWeight.bold,
                        color: blackCustom,
                        fontSize: 22.0
                      ),
                    ),
                    Container(height:15.0),
                    Text(
                      shopItem.subTitle,
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight:FontWeight.w500,
                          fontSize: 14.0,
                        color: blackCustom,
                      ),
                    ),
                    Container(height:15.0),
                    Row(
                      children: <Widget>[
                        Container(
                          width:100.0,
                          height:33.0,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            image:DecorationImage(
                              image: AssetImage(
                                'assets/image/offerstag.png',
                              ),
                            )
                          ),
                          child:Text(
                            '40%',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight:FontWeight.bold
                            ),
                          )
                        ),
                        Text(
                          'From',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 13.0,
                            color: Colors.deepOrange
                          ),
                        ),
                        Container(width:4.0),
                        Image.asset(
                          'assets/image/rupee_normal.png',
                          color: Colors.deepOrange,
                          width: 5.0,
                          height: 8.0,
                        ),
                        Container(width:8.0),
                        Text(
                          '${shopItem.itemRate.toString()}'.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'JosefinSans',
                              fontWeight:FontWeight.w500,
                              fontSize: 26.0,
                              color: Colors.deepOrange
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Text(
                      'Color'.toUpperCase(),
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: blackCustom,
                          fontWeight:FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ),
                    Container(height:10.0),
                   ColorSelector(
                     colors: shopItem.colorChoices.map((colorChoice){
                       return colorChoice.colorValue;
                     }).toList(),
                     onTap: (Color color){
                       print(color);
                     },
                   ),
                    Divider(),
                    Text(
                      'Size'.toUpperCase(),
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: blackCustom,
                          fontWeight:FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ),
                    Container(height: 10.0,),
                    SizeSelector(
                      clothingType: shopItem.clothingType,
                      shirtSizeTypes: shopItem.shirtSizeTypes,
                      jeansSizeTypes: shopItem.jeansSizeTypes,

                      onTap: (size){
                        print(size);
                        _applySize(size);
                      },

                    ),
                    Container(height: 10.0,),
                    Text(
                      'About'.toUpperCase(),
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: blackCustom,
                          fontWeight:FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ),
                    Container(height:5.0),
                    Text(
                      shopItem.about,
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight:FontWeight.w500,
                          fontSize: 14.0
                      ),
                    ),
                    Container(height:5.0),
                    Row(
                      children: <Widget>[
                        Text(
                          'Delivery'.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              color: blackCustom,
                              fontWeight:FontWeight.bold,
                              fontSize: 18.0
                          ),
                        ),
                        Expanded(child: Container(),),
                        Image.asset('assets/image/schedule_delivery_truck.png',width:50.0,height:50.0)
                      ],
                    ),
                    Row(
                      children:<Widget>[
                        Text(
                          'Supported Courier',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              color: blackCustom,
                              fontSize: 14.0
                          ),
                        ),
                        Expanded(child:Container()),
                        Text(
                          'Blue Dart',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight:FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 14.0
                          ),
                        )
                      ]
                    ),
                    Row(
                      children:<Widget>[
                        Text(
                          'Item Location',
                          style: TextStyle(
                              color: blackCustom,
                              fontFamily: 'OpenSans',
                              fontSize: 14.0
                          ),
                        ),
                        Expanded(child:Container()),
                        Text('Delhi , Faridabad')
                      ]
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Text(
                          'Contact Seller',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              color: blackCustom,
                              fontWeight:FontWeight.bold,
                              fontSize: 18.0
                          ),
                        ),
                        Expanded(child:Container()),
                        Text(
                          shopItem.sellerContact,
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              color: Colors.deepOrange,
                              fontWeight:FontWeight.bold,
                              fontSize: 18.0
                          ),
                        ),
                      ],
                    ),
                    Container(height:50.0)

                  ],
                ),
              )
            ],
          ),

          Positioned(
            top:0.0,right:0.0,left:0.0,
            child: ScopedModelDescendant<CartBloc>(
              builder: (BuildContext context , child , model){
                return AppBar(
                    actions: <Widget>[
                      Stack(
                        children: <Widget>[
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.shopping_cart,color:Colors.white),
                          ),
                          Positioned(
                            right:0.0,
                            child: Container(
                              padding:EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape:BoxShape.circle,
                                  color:Colors.deepOrange
                              ),
                              child: Text(
                                  '${model.cartItems.length}',
                                  style:TextStyle(
                                      color:Colors.white,
                                      fontFamily: 'JosefinSans'
                                  )
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                    elevation: 0.0,
                    backgroundColor: Colors.deepOrange.withOpacity(0.5),
                    leading:BackButton(color: Colors.white,)
                );
              },
            ),
          ),
          Positioned(
            height:60.0,
            bottom:0.0,right:0.0,left: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45.withOpacity(0.3),
                      spreadRadius: 3.0,
                      blurRadius: 10.0
                    )
                  ]
                ),
                transform: Matrix4.translationValues(0.0, 10.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                     Expanded(
                        child: Container(
                        decoration: BoxDecoration(
                        border:Border.all(
                        width: 2.0,
                        color: Colors.deepOrange
                          ),
                        ),
                          child: ScopedModelDescendant<CartBloc>(
                            builder:(context,child,model){
                              return FlatButton(
                                  color: Colors.white,
                                  onPressed: (){
                                    model.addItem(
                                      Cart(
                                        itemName: 'Shirt xa Saven',
                                        itemImageUrl: '',
                                        itemCount: 1,
                                        itemRate: '1,999'
                                      )
                                    );
                                  },
                                  child:Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.add_shopping_cart,color: Colors.deepOrange,),
                                        Text(
                                          'Add to Cart',
                                          style: TextStyle(
                                              color: Colors.deepOrange,
                                              fontFamily: 'JosefinSans'
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              );
                            },
                          ),
                        ),
                      ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border:Border.all(
                              width: 2.0,
                              color: Colors.deepOrange
                          ),
                        ),
                        child: FlatButton(
                          color: Colors.deepOrange,
                          onPressed: (){},
                            child:Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.flash_on,color: Colors.white,),
                                  Text(
                                    'Buy Now',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'JosefinSans'
                                    ),
                                  )
                                ],
                              ),
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}






