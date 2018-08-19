
import 'package:flutter/material.dart';
import 'package:stockcart/pages/cart_screen/cart_bloc.dart';

class ColorSelector extends StatefulWidget {
  final List<Color> colors;
  final Function onTap;
  Color selectedColor;
  ColorSelector({
    this.colors = const [],
    this.onTap,
  }){
    this.selectedColor = colors.length !=0 ? colors[0] : Colors.transparent;
  }

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {


  List<Widget> _buildColors(){
    return widget.colors.map((color){
      return GestureDetector(
        onTap: (){
          widget.onTap(color);
          setState(() {
            widget.selectedColor = color;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Colors.black26,
                    width: 1.0
                )
            ),
            child: Container(
                padding: EdgeInsets.all(10.0),
                margin:EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: color,
                  shape:BoxShape.circle,
                ),
                child:widget.selectedColor != color ? Container() : Icon(Icons.check,color: Colors.white,size: 20.0,)
            )
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _buildColors(),
      ),
    );
  }
}