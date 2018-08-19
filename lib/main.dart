import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stockcart/components/customAppbar.dart';
import 'package:stockcart/pages/account_screen/account_screen.dart';
import 'package:stockcart/pages/cart_screen/cart_bloc.dart';
import 'package:stockcart/pages/cart_screen/cart_screen.dart';
import 'package:stockcart/pages/home_screen/index.dart';
import 'package:stockcart/pages/home_screen_deals.dart';
import 'package:stockcart/pages/item_detail/index.dart';
import 'package:stockcart/pages/orders_screen.dart';
import 'package:stockcart/pages/wishlist_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'components/navigation-icon-view.dart';


Future<void>  main() async  {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'test',
    options: const FirebaseOptions(
<<<<<<< HEAD
      googleAppID: 'GooleAppId',
      gcmSenderID: 'gcmSenderId',
      apiKey: 'Api Key',
      projectID: 'id-project',
=======
      googleAppID: '',
      gcmSenderID: '2',
      apiKey: '',
      projectID: '',
>>>>>>> 84d8ec903e915b307bf19da7ccbc43f564ebfa0b
    ),
  );
  final Firestore firestore = new Firestore(app: app);
  runApp(
    new ScopedModel<CartBloc>(
      model: new CartBloc(),
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: new BottomNavigationApp(firestore),
      ),
    ),
  );
}




class BottomNavigationApp extends StatefulWidget {
  final Firestore firestore;
  BottomNavigationApp(this.firestore);
  @override
  _BottomNavigationAppState createState() => new _BottomNavigationAppState();
}

class _BottomNavigationAppState extends State<BottomNavigationApp>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.home),
        title: 'Deals',
        page: new HomeScreenIndexPage(widget.firestore),
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.supervisor_account),
        title: 'Account',
        page: AccountScreen(),//new AccountScreen(),
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.assessment),
        title: 'Orders',
        page: new OrderScreen(),
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.favorite),
        title: 'Wishlist',
        page: new WishlistScreen(),
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.shopping_cart),
        title: 'Cart',
        page: new CartScreen(),
        vsync: this,
      ),
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews) view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _navigationViews) {
      transitions.add(view.transition(_type, context));
    }

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        child: _buildTransitionsStack()
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
