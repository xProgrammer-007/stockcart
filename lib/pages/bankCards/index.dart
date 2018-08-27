

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stockcart/components/customAppbar.dart';
import 'package:stockcart/pages/account_screen/account_bloc.dart';
import 'package:stockcart/pages/bankCards/bloc.dart';

class SavedCards extends StatefulWidget {

  @override
  _SavedCardsState createState() => _SavedCardsState();
}

class _SavedCardsState extends State<SavedCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
          onPressed: (){},
          backgroundColor: Colors.orange,
         child: Icon(Icons.add,color: Colors.white,),
      ),
      body: new ScopedModelDescendant<AccountBloc>(
        builder: (context,child,model){
         final AccountBloc accountBlocModel = model;
          if (!model.isLoggedIn || model.userData == null) return
              Center(child: Row(
                children: <Widget>[
                  new Text('Add a card'),
                  Icon(Icons.add,color: Colors.black38,)
                ],
              ));
          return ScopedModelDescendant<BankCardBloc>(
            builder: (context,child,model){

              print(accountBlocModel.userData.value.displayName);
              return new StreamBuilder<QuerySnapshot>(
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData) return
                    new CircularProgressIndicator();
                  return ListView.builder(
                    itemBuilder: (BuildContext context , int i){
                      return SingleBankCardView(
                        bankCard: BankCard.fromDocumentSnapshot(snapshot.data.documents[i]),
                      );
                    },
                    itemCount: snapshot.data.documents.length,
                  );
                },
                stream: model.firestore.collection('CardSaved').document(accountBlocModel.userData.value.uid).collection('BankCards').snapshots(),
              );
            },
          );
        },
      ),
    );
  }
}


class SingleBankCardView extends StatelessWidget {
  
  final BankCard bankCard;
  Color cardColor = Colors.redAccent;
  SingleBankCardView({@required this.bankCard});
  
  @override
  Widget build(BuildContext context) {
    Widget _cardAssetLogo(){
     String assetPath = 'assets/image/';
     switch(bankCard.cardType){
       case CardType.MasterCard:
         assetPath += 'mastercard.png';
         cardColor = Colors.blueAccent;
         break;
       case CardType.Visa:
         assetPath += 'visa.png';
         cardColor = Colors.brown;
         break;
       case CardType.Discover:
         assetPath += 'discover.png';
         break;
       case CardType.Rupay:
         assetPath += 'rupay.png';
         break;
       case CardType.Maestro:
         assetPath += 'maestro.png';
         break;
     }
      return new Image.asset(assetPath,width: 70.0);
    }
    return Container(
      padding: EdgeInsets.all(20.0),
      height: 230.0,
      child: new Card(
        color: cardColor,
        elevation: 5.0,
        child: CustomPaint(
          painter: CirclePaintCard(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _cardAssetLogo(),
                Container(height:20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${bankCard.cardUid16Digits.substring(0,2) + '..'}',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: 'OpenSans',
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                          '....',
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ), Expanded(
                      child: Text(
                          '....',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'OpenSans',
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ), Expanded(
                      child: Text(
                          '....',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'OpenSans',
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Container(height: 12.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'CARD HOLDER',
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.white70,
                          fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'EXPIRES',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.0,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),Container(height: 8.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${bankCard.cardHolderName}',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'JosefinSans',
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      '${bankCard.expiryDate}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class CirclePaintCard extends CustomPainter{
  Paint circlePaint;

  CirclePaintCard():circlePaint = new Paint(){
    circlePaint
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0
      ..color = Colors.white.withAlpha(0x10);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(0.0 , 0.0),
        70.0,
        circlePaint
    );
    canvas.drawCircle(
        Offset(-205.0 , -10.0),
        80.0,
        circlePaint
    );
    canvas.drawCircle(
        Offset(size.width , size.height/3),
        170.0,
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
