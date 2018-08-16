
import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  final List<Color> colors;
  final Function onTap;
  Color selectedColor;
  ColorSelector({
    this.colors = const [],
    this.onTap
  }){
    this.selectedColor = colors.length !=0 ? colors[0] : Colors.transparent;
  }

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {


  List<Widget> _buildColors(){
    return widget.colors.map((color){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal:10.0),
        child: GestureDetector(
          onTap: (){
            widget.onTap(color);
            setState(() {
              widget.selectedColor = color;
            });
          },
          child: Container(
              width:25.0,
              height:25.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.black12,
                      width: 2.0
                  )
              ),
              child: Container(
                  margin:EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: color,
                    shape:BoxShape.circle,
                  ),
                  child:widget.selectedColor != color ? Container() : Icon(Icons.check,color: Colors.white,size: 15.0,)
              )
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _buildColors(),
      ),
    );
  }
}