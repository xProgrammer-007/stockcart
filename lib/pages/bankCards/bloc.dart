
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';

class BankCardBloc extends Model{

  final Firestore firestore;
  
  BankCardBloc({this.firestore});


  Future<List<BankCard>> getSavedCards(String uid) async {
    print(uid);
     List<BankCard> bankCards;
    final Stream<QuerySnapshot> docs = firestore.collection('CardSaved').document(uid).collection('BankCards').snapshots();
      docs.isEmpty.then((bool value){
        value ? print('no data') : print("ues data");
      });
     docs.listen((QuerySnapshot snapshot){
       bankCards = snapshot.documents.map((DocumentSnapshot snapshot){
         print(snapshot.data);
         return new BankCard.fromDocumentSnapshot(snapshot);
       }).toList();
    }).asFuture();
     return bankCards;
  }

  Future<bool> saveCard(BankCard card,String uid) async{
   bool returnValue;
    await Firestore.instance.collection('CardSaved').document(uid).setData(card.toMap()).then((_)=> returnValue = true).catchError((error) {
      print(error);
      returnValue = false;
    });
    return returnValue;
  }

}


class BankCard{
   String cardUid16Digits;
   CardType cardType;
   String expiryDate;
   String cardHolderName;
   int cvv;


  BankCard({
    this.cardType,
    this.cardHolderName,
    this.cardUid16Digits,
    this.cvv,
    this.expiryDate
  });


  CardType _decideCardType(String cardType){
   CardType _cardType;
    switch(cardType){
      case 'CardType.Rupay':
        _cardType = CardType.Rupay;
        break;
      case 'CardType.Maestro':
        _cardType = CardType.Maestro;
        break;
      case 'CardType.Discover':
        _cardType = CardType.Discover;
        break;
      case 'CardType.Visa':
        _cardType = CardType.Visa;
        break;
      case 'CardType.Mastercard':
        _cardType = CardType.MasterCard;
        break;
    }
    return _cardType;
  }

  BankCard.fromDocumentSnapshot(DocumentSnapshot snapshot){
    cardType = _decideCardType(snapshot['cardType'].toString());
    cardUid16Digits = snapshot["cardUid16Digits"].toString();
    cardHolderName = snapshot["cardHolderName"].toString();
    cvv = int.parse(snapshot["cvv"].toString());
    expiryDate = snapshot["expiryDate"];
  }

   Map toMap(){
    Map map = new Map();
    map['cardType'] = cardType;
    map['cardUid16Digits'] = cardUid16Digits;
    map['cardHolderName'] = cardHolderName;
    map['cvv'] = cvv;
    map['expiryDate'] = expiryDate;
    return map;
   }




}


enum CardType{
  Rupay,
  Maestro,
  Discover,
  Visa,
  MasterCard,
}

