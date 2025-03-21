import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter/models/cart_model.dart';
import 'package:provider_flutter/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart Page", 
          style: TextStyle(
          color: Colors.deepOrange,
          fontWeight: FontWeight.bold,
          fontSize: 30),
          ),
      ),
      body: Consumer<CartProvider>(
        builder: (BuildContext context, CartProvider cartProvider, Widget? child){
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                      final CartItem cartItem = cartProvider.items.values.toList()[index];

                     return Container(
                      color: const Color.fromARGB(53, 255, 153, 0),
                       margin: EdgeInsets.all(5),
                       child: ListTile(
                          title: Text(cartItem.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cartItem.id),
                              Text("\$${cartItem.price} x ${cartItem.quantity}"),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            IconButton(
                              onPressed: (){
                                cartProvider.removeSingleItem(cartItem.id);
                            }, 
                            icon:const Icon(Icons.remove),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: (){
                                cartProvider.removeItem(cartItem.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                              content: Text("Remove items from cart successfully!"),
                              duration:  const Duration(seconds: 1),
                              ),
                           );
                            }, 
                            icon:const Icon(Icons.remove_shopping_cart),
                            ),
                          ],),
                       ),
                     ); 
                  },
                  )
                )
            ]
          );
          
        }
        ),
    );
  }
}