
import 'package:flutter/material.dart';

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