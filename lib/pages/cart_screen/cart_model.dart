
import 'package:flutter/material.dart';


class Cart{
   String itemName;
   String itemRate;
   String itemImageUrl;
   int itemCount;
   Color itemColor;
   String id;
   ClothingType clothingType;
   String subTitle;
   int salePercent;
   ShirtSizeType shirtSizeType;
   int jeansSizeType;


  Cart({
    this.itemName = '',
    @required this.id,
    this.clothingType = ClothingType.none,
    this.jeansSizeType = 0,
    this.shirtSizeType = ShirtSizeType.none,
    this.itemCount = 1,
    this.itemColor = Colors.white,
    this.itemImageUrl = '',
    this.itemRate = '',
    this.salePercent = 0,
    this.subTitle = '',
  });



}


enum ShirtSizeType{
  xs,
  s,
  m,
  lg,
  xl,
  xxl,
  none
}



enum JeansSizeType{
  size_36,
  size_37,
  size_38,
  size_39,
  size_40,
  size_41,
  size_42,
  size_43,
  size_44,
  size_45,
  none
}


enum ClothingType{
  jeans,
  shirt,
  shoes,
  tee_shirt,
  none
}

class CustomColor{
  String colorHex;
  String name;
  Color colorValue;

  CustomColor({
      this.colorHex = '',
      this.name = ''
    }){
    colorValue = new Color(int.parse('0xFF$colorHex'));
  }

  Map toMap(){
    Map map = new Map();
    map["colorHex"] = colorHex;
    map["name"] = name;
    return map;
  }


}



