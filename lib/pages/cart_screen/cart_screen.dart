import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stockcart/components/customAppbar.dart';
import 'package:stockcart/pages/cart_screen/cart_bloc.dart';
import 'package:stockcart/pages/cart_screen/cart_model.dart';
import 'package:stockcart/pages/item_detail/sizeConverters.dart';

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
    return size;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                                child:Text(
                                  'No items in cart',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.black54
                                  ),
                                )
                            ),
                          )
                        ])
                    ) :
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 20.0,
                          childAspectRatio: 1.7
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
            // },
          ),
        ),

        new PositionedAppbarCart(),
      ],
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
  const PositionedAppbarCart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top:0.0,right:0.0,left:0.0,
      child: AppBarCustomCurved(
        showActions: false,
        showLeading: false,
        height:100.0,
        title: Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                  'Summary',
                  style:TextStyle(
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:4.0),
                child: Container(width:20.0,height:2.5,color: Colors.white.withOpacity(0.6),),
              ),
              Text(
                  'Checkout',
                  style:TextStyle(
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:4.0),
                child: Container(width:20.0,height:2.5,color: Colors.white.withOpacity(0.6),),
              ),
              Text(
                  'Payment',
                  style:TextStyle(
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0
                  )
              ),
            ],
          ),
        ),
        subtitle: Container(
//          padding: EdgeInsets.only(top:20.0),
//          height: 30.0,
//          width: double.infinity,
//          child: Material(
//              color: Colors.transparent,
//              child: DottedProgressIndicator()
//          ),
        ),
      ),
    );
  }
}

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
    this.size = ''
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
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text(
                          'Rs ${widget.rate}',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FadeInImage(
                          placeholder: AssetImage(
                            'assets/placeholder_image.png',
                          ),
                          fit: BoxFit.cover,
                          height: 100.0,
                          width:100.0,
                          image: NetworkImage(
                              widget.networkImagePath,
                          ),
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
                                  fontFamily: 'OpenSans'
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


class DottedLinePrinter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedLinePainter(
          noOfDots: 40
      ),
    );
  }
}



class DottedLinePainter extends CustomPainter{
  Paint dottedLinePaint;
  final int noOfDots;

  DottedLinePainter({
    this.noOfDots = 30,
  }):dottedLinePaint = new Paint(){
    dottedLinePaint
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0
      ..color = Colors.white.withOpacity(0.6);
  }

  @override
  void paint(Canvas canvas, Size size) {


    for(var i =0;i<noOfDots;++i){
      final startX = i.roundToDouble() * size.width / noOfDots;
      final endX = (i.roundToDouble() * size.width / noOfDots ) + 5.0;
      canvas.drawLine(
          Offset(startX,0.0),
          Offset(endX,0.0),
          dottedLinePaint
      );

    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}






class DottedProgressIndicator extends StatelessWidget {
  final double progressPercent;
  final Color color;
  DottedProgressIndicator({
    this.color = Colors.greenAccent,
    this.progressPercent = 0.5
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(bottom:5.0),
      height: 30.0,
      width: double.infinity,
      child: Stack(
        fit:StackFit.expand,
        children: <Widget>[
          DottedLinePrinter(),
          CustomPaint(
            painter: ProgressPainter(
            ),
            child: Container(),
          )
          //CustomPaint
        ],
      ),
    );
  }
}



class ProgressPainter extends CustomPainter{
  final double progressPercent;
  final Color color;
  Paint progressPainter;
  ProgressPainter({
    this.progressPercent = 0.4,
    this.color = Colors.white
  }):progressPainter = new Paint(){
    takeVowelsOut("Axkknaeiou");
    progressPainter
      ..strokeCap = StrokeCap.round
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.5;


  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset(0.0,0.0),
        Offset(size.width - (size.width * progressPercent),0.0),
        progressPainter);

    canvas.drawCircle(
        Offset(size.width - (size.width * progressPercent),0.0),
        10.0,
        progressPainter
    );



    progressPainter
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.black26;



//    canvas.drawCircle(
//        Offset(size.width - (size.width * progressPercent),0.0),
//        12.0,
//        progressPainter
//    );

    progressPainter
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.5
      ..color = Colors.red;

    canvas.drawCircle(
        Offset(size.width - (size.width * progressPercent),0.0),
        3.0,
        progressPainter
    );



  }

  makeCirclePath(Size size){
    Path path = new Path();
    path.addOval(
        Rect.fromCircle(
            center: Offset(size.width - (size.width * progressPercent),5.0),
            radius: 15.0
        )
    );
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}


String takeVowelsOut(String word){
  String result;
  for(var i = 0;i<word.length -1;i++){
    result = ['a','e','i','o','u'].map((char){
      return char != word.substring(i,i+1);
    }).join("");
  }
  return result;
}