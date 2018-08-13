//Designs

import 'package:flutter/material.dart';
import 'package:stockcart/pages/cart_screen/cart_model.dart';
import 'package:stockcart/pages/item_detail/index.dart';

class HomeScreenIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: FadeInImage(
              placeholder: AssetImage(
                'assets/image/placeholder.jpg',
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
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              childAspectRatio: 0.7,
            mainAxisSpacing: 2.0
          ),
          delegate: SliverChildBuilderDelegate((BuildContext context , int i){
            return Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(
                    builder: (BuildContext context) => new CartItemDetails(
                      shopItem: new ShopItem(
                        images: ['assets/image/shirt.jpg'],
                        salePercent: 40,
                        itemRate: 1999,
                        itemImageUrl: '',
                        itemName: 'Jeans Super Chelwa Version',
                        clothingType: ClothingType.jeans,
                        subTitle: 'Chelwa v 2.0 released',
                        colorChoices: [
                          new CustomColor('Chewla ','fa9a9c'),
                          new CustomColor('Chewla ','fefbfc'),
                          new CustomColor('Chewla ','ff9800'),
                        ],
                        jeansSizeTypes: JeansSizeType.values.sublist(0,10),
                        sellerContact: '+7330956904',
                        about: 'Lorem Ipsum dor sit amet foker',

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
                              'assets',
                            ),
                          fit: BoxFit.cover,
                          placeholder: AssetImage('assets/image/placeholder_image.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:5.0),
                        child: Text(
                          'Men Jeans Grey',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:5.0),
                        child: Container(
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
                              '600',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            Expanded(child: Container(),),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal:5.0,vertical:1.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.add,color: Colors.white,),
                                    Text(
                                      'ADD',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500
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
                  ),
                ),
              ),
            );
          },childCount: 10),
        )
      ],
    );
  }
}
