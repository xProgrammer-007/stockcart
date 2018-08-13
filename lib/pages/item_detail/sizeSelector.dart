import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stockcart/pages/cart_screen/cart_bloc.dart';
import 'package:stockcart/pages/cart_screen/cart_model.dart';
import 'package:stockcart/pages/item_detail/sizeConverters.dart';

class SizeSelector extends StatefulWidget {

  ClothingType clothingType;
  final Function onTap;
  final List<ShirtSizeType> shirtSizeTypes;
  final List<JeansSizeType> jeansSizeTypes;
  String selectedSize;

  SizeSelector({
    this.clothingType = ClothingType.none,
    this.jeansSizeTypes = const [],
    this.shirtSizeTypes = const [],
    this.onTap,
  }){
    selectedSize
    = clothingType == ClothingType.jeans
        ? jeansSizeTypes.length != 0 ? _determineSize(jeansSizeTypes[0]) : null
        : clothingType == ClothingType.shirt
        ? shirtSizeTypes.length != 0 ? _determineSize(shirtSizeTypes[0]) : null
        : clothingType == ClothingType.tee_shirt
        ? shirtSizeTypes.length != 0 ? _determineSize(shirtSizeTypes[0]) : null
        : null
    ;
  }

  String _determineSize(size){
    if(clothingType == ClothingType.jeans){
      return jeansSizeToString(size);
    }else if(clothingType == ClothingType.shirt) {
      return shirtSizeToString(size);
    }else if(clothingType == ClothingType.tee_shirt){
      return shirtSizeToString(size);
    }else{
      print('_determine Size clothing type mismatch');
      return 'mismatch';
    }


  }

  @override
  SizeSelectorState createState() {
    return new SizeSelectorState();
  }
}

class SizeSelectorState extends State<SizeSelector> {

  List sizes;




  List<Widget> _buildSelector(model){

    switch(widget.clothingType){
      case ClothingType.jeans:
        sizes = widget.jeansSizeTypes;
        break;
      case ClothingType.shirt:
        sizes = widget.shirtSizeTypes;
        break;
      case ClothingType.tee_shirt:
        sizes = widget.shirtSizeTypes;
        break;
      case ClothingType.none:
        break;
      case ClothingType.shoes:
        break;
    }



    return sizes.map((size){
      return GestureDetector(
        onTap: (){
          widget.onTap(size);
          setState(() {
            widget.selectedSize = widget._determineSize(size);
          });
        },
        child: Container(

          margin: EdgeInsets.symmetric(horizontal:3.0),
          padding: EdgeInsets.all(7.0),
          decoration: BoxDecoration(
              color: widget.selectedSize == widget._determineSize(size) ? Colors.deepOrange : Colors.white,
              border: Border.all(
                  width: 1.0,
                  color: widget.selectedSize == widget._determineSize(size) ? Colors.transparent : Colors.black12
              )
          ),
          child: Text(
            '${widget._determineSize(size).toUpperCase()}',
            style: TextStyle(
                fontFamily: 'JosefinSans',
                color: widget.selectedSize == widget._determineSize(size) ? Colors.white : Colors.black54
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartBloc>(
      builder: (context,child,model){
        return Row(
          children: _buildSelector(model),
        );
      },
    );
  }
}




