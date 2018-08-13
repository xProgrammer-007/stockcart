import 'package:flutter/material.dart';

class AppBarCustomCurved extends StatelessWidget {
  final bool showLeading;
  final bool showActions;
  final Widget title;
  final Widget subtitle;
  final double height;

  AppBarCustomCurved({
    this.showLeading = true,
    this.subtitle,
    this.title,
    this.height = 100.0,
    this.showActions  = true
  });
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ShadowPainter(),
      child: ClipPath(
        clipper: CurveClipper(),
        child: Stack(
          children: <Widget>[
            new Container(
                width: double.infinity,
                height: height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: FractionalOffset.centerLeft,
                        end: FractionalOffset.centerRight,
                        colors: [Colors.pinkAccent,Colors.redAccent],//[const Color(0xFF5d65ba)  , const Color(0xFF673b86)],
                        stops: [0.4,1.0]
                    )
                ),
                child:Column(
                  //mainAxisAlignment:MainAxisAlignment.center,
                  children: <Widget>[
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      centerTitle:true,
                      title: Column(
                        children: <Widget>[
                          title,
                          subtitle
                        ],
                      ),
                      leading:showLeading ? IconButton(
                        onPressed: null,
                        icon: Icon(Icons.menu,color: Colors.white),
                      ) : null,
                      actions: showActions ? <Widget>[
                        IconButton(
                          onPressed: null,
                          icon: Icon(Icons.shopping_cart,color: Colors.white),
                        )
                      ] : null,
                    ),
                    CustomPaint(
                      painter:CirclePaint(),
                    ),
                    //subtitle
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}




class BigAndSmallText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Color color;
  final double fontSize;
  final double smallFontSize;

  BigAndSmallText({
    this.firstText = '',
    this.secondText = '',
    this.color = Colors.black45,
    this.fontSize = 19.0,
    this.smallFontSize = 13.0
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          firstText,
          style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.bold
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(0.0, -5.0,0.0),
          child: Padding(
            padding: const EdgeInsets.only(left:5.0),
            child: Text(
                secondText,
                style:TextStyle(
                    color:color,
                    fontSize: smallFontSize
                )
            ),
          ),
        )
      ],
    );
  }
}


class CirclePaint extends CustomPainter{
  Paint circlePaint;

  CirclePaint():circlePaint = new Paint(){
    circlePaint
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0
      ..color = Colors.white.withAlpha(0x10);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(-175.0 , -70.0),
        70.0,
        circlePaint
    );
    canvas.drawCircle(
        Offset(-205.0 , -10.0),
        80.0,
        circlePaint
    );
    canvas.drawCircle(
        Offset(135.0 , -80.0),
        70.0,
        circlePaint
    );
    canvas.drawCircle(
        Offset(145.0 , 20.0),
        70.0,
        circlePaint
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

class ShadowPainter extends CustomPainter{
  Paint ShadowPaint;
  ShadowPainter():ShadowPaint = new Paint(){
    ShadowPaint
      ..strokeWidth = 3.0
      ..color = const Color(0x44000000)
      ..style = PaintingStyle.fill;

  }
  @override
  void paint(Canvas canvas, Size size) {


    canvas.drawShadow(
        getCurvedPath(size),
        Colors.deepPurpleAccent.withAlpha(100),
        10.0,
        true
    );

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }


}


class CurveClipper extends CustomClipper<Path>{
  Path path;
  CurveClipper():path = new Path();
  Offset startOffset;
  Offset endOffset;
  @override
  Path getClip(Size size) {
    return getCurvedPath(size);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}

Path getCurvedPath(Size size){
  Path path = new Path();
  Offset startOffset;
  Offset endOffset;
  path.lineTo(0.0, size.height - 30);

  startOffset = Offset(size.width /4, size.height);
  endOffset = Offset(size.width/2 , size.height);
  path.quadraticBezierTo(startOffset.dx, startOffset.dy, endOffset.dx, endOffset.dy);

  startOffset = Offset(size.width - (size.width /4), size.height);
  endOffset = Offset(size.width , size.height - 30);
  path.quadraticBezierTo(startOffset.dx, startOffset.dy, endOffset.dx, endOffset.dy);

  path.lineTo(size.width,0.0);
  return path;
}