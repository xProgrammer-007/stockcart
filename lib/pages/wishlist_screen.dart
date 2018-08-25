import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stockcart/pages/cart_screen/cart_bloc.dart';
import 'package:stockcart/pages/wishlist_screen/index.dart';

class WishlistScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartBloc>(
        builder: (context,child,model){
          return new WishlistIndexScreen(model:model);
        },
      );
  }
}
