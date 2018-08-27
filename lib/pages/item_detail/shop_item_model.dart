import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stockcart/pages/cart_screen/cart_model.dart';

class ShopItem{
  List<String> images;
  String subTitle;
  String salePercent;
  List<CustomColor> colorChoices;
  List<ShirtSizeType> shirtSizeTypes;
  List<int> jeansSizeTypes;
  String about;
  String sellerContact;
  String id;

  String itemName;
  String itemRate;
  String itemImageUrl;
  ClothingType clothingType;
  dynamic recordKey;
  int itemCount;
  Color itemColor;
  ShirtSizeType shirtSizeType;
  int jeansSizeType;

  ShopItem({
    this.images = const [],
    @required this.id,
    this.subTitle = '',
    this.colorChoices = const [],
    this.salePercent,
    this.recordKey,
    this.shirtSizeTypes = ShirtSizeType.values,
    this.jeansSizeTypes = const [],
    this.about = '',
    this.sellerContact = '',
    this.itemName = '',
    this.clothingType = ClothingType.none,
    this.itemCount = 1,
    this.itemColor = Colors.white,
    this.itemImageUrl = '',
    this.itemRate = ''

  }){
    //print(clothingType);
    subTitle  = subTitle == null || subTitle == '' ? ' '.toString() : subTitle;
    salePercent  = salePercent == null ? '' : salePercent;
    about  = about == null ? '' : about;
    sellerContact  = sellerContact == null ? '' : sellerContact;
    itemName  = itemName == null ? '' : itemName;
    itemRate  = itemRate == null ? '' : itemRate;
    itemImageUrl  = itemImageUrl == null ? '' : itemImageUrl;


  }

  ShopItem.fromDocumentSnapshot(DocumentSnapshot document){

    ClothingType _decideClothingType(clothingType){
      ClothingType type;
      //print(clothingType.toString());
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

    List<ShirtSizeType>_shirtSizeMaker(List<dynamic> sizes){
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

    final clothingTypeQuery = _decideClothingType(document['clothingType']);

      id=document.documentID.toString();
      images= (document['images'] as List)
          .map((f)=>f.toString()).toList().cast<String>().toList();
      salePercent = document['salePercent'].toString();
      itemRate = document['itemRate'].toString();
      itemName = document['itemName'].toString();
      clothingType = clothingTypeQuery;
      subTitle = document['subTitle'].toString();
      itemCount = 1;
      itemImageUrl = document['itemImageUrl'].toString();
      colorChoices = (document['colorChoices'] as List).map((hexColor){
        return new CustomColor(
            name: 'Chewla ',
            colorHex:hexColor.toUpperCase()
        );
      }).toList();
      jeansSizeTypes= clothingType == ClothingType.jeans
          ? _numberSizeMaker((document['jeansSizeTypes'] != null ? document['jeansSizeTypes'] : const [] as List).cast<String>().toList())
          : [];
      shirtSizeTypes= clothingType == ClothingType.shirt
          ? _shirtSizeMaker((document['shirtSizeTypes'] as List))
          : [];
      sellerContact= document['sellerContact'].toString();
      about= document['about'].toString();

  }

  ShopItem.fromMap(Map document , dynamic recordKey){

    ClothingType _decideClothingType(clothingType){
      ClothingType type;
      //print(clothingType.toString());
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

    List<ShirtSizeType> _shirtSizeMaker(List sizes){
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

    final clothingTypeQuery = _decideClothingType(document['clothingType']);
    //print(document['shirtSizeTypes']);
    recordKey = recordKey;
    id=document['id'].toString();
    images= (document['images'] as List)
        .map((f)=>f.toString()).toList().cast<String>().toList();
    salePercent = document['salePercent'].toString();
    itemRate = document['itemRate'].toString();
    itemName = document['itemName'].toString();
    clothingType = clothingTypeQuery;
    itemImageUrl = document['itemImageUrl'].toString();
    subTitle = document['subTitle'].toString();
    colorChoices = (document['colorChoices'] as List).map((customColor){
      return new CustomColor(
          name: customColor['colorHex'],
          colorHex:customColor['colorHex'].toUpperCase()
      );
    }).toList();
    jeansSizeTypes= clothingType == ClothingType.jeans
        ? _numberSizeMaker((document['jeansSizeTypes'] != null ? document['jeansSizeTypes'] : const [] as List).cast<int>().toList())
        : null;
    shirtSizeTypes = clothingType == ClothingType.shirt
        ? _shirtSizeMaker((document['shirtSizeTypes']  as List).cast<String>().toList())
        : null;
    sellerContact= document['sellerContact'].toString();
    about= document['about'].toString();

  }

  Map toJson(){
    Map map = new Map();
    map["images"] = images;
    map["id"] = id;
    map["subTitle"] = subTitle;
    map["colorChoices"] = colorChoices.map((CustomColor customColor){
      return customColor.toMap();
    }).toList();
    map["salePercent"] = salePercent;
    map["shirtSizeTypes"] = shirtSizeTypes.map((ShirtSizeType type) => type.toString()).toList();
    map["jeansSizeTypes"] = jeansSizeTypes;
    map["about"] = about;
    map["sellerContact"] = sellerContact;
    map["itemName"] = itemName;
    map["clothingType"] = clothingType.toString();
    map["itemCount"] = itemCount;
    map["itemColor"] = itemColor.toString();
    map["itemImageUrl"] = itemImageUrl;
    map["itemRate"] = itemRate;
    return map;
  }
}
