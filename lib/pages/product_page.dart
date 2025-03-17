import 'package:flutter/material.dart';
import 'package:provider_flutter/data/product_data.dart';
import 'package:provider_flutter/models/product_model.dart';
import 'package:provider_flutter/pages/cart_page.dart';
import 'package:provider_flutter/pages/favourite_page.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
   final List<Product> products = ProductData().products;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Shop", 
        style: TextStyle(
          color: Colors.deepOrange,
          fontWeight: FontWeight.bold,
          fontSize: 30
        )),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: (){
                  Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => const FavouritePage()
                      ),
                      );
          },
          backgroundColor: Colors.deepOrange,
          heroTag: "fav_btn",
          child: const Icon(
            Icons.favorite, 
            color: Colors.white),
            ),

            const SizedBox(width: 20,),

            FloatingActionButton(onPressed: (){
              Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => const CartPage()
                      ),
                      );
            },
            heroTag: "shopping_btn",
            backgroundColor: Colors.deepOrange,
          child: const Icon(
            Icons.shopping_cart,
            color: Colors.white,),
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder:  (context, index){
          final Product product = products[index];
          return Card(
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    product.title, 
                    style: TextStyle(
                    fontWeight: FontWeight.bold,

                  )),
                  const SizedBox(width: 50,),
                  //todo fill this
                  Text("0"),
                ],
              ),
              subtitle: Text("\$${product.price.toString()}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                    Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => const FavouritePage()
                      ),
                      );
                  }, 
                  icon: const Icon(
                    Icons.favorite)
                  ),
                  IconButton(
                    onPressed: () {
                    Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => const CartPage()
                      ),
                      );
                  }, 
                  icon: const Icon(
                    Icons.shopping_cart)
                  ),
                ],
              ),
              )
          );
        }
        ),
    );
  }
}