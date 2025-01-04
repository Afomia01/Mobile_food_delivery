// import 'package:flutter/material.dart';
// import 'package:food_prime_app/screens/payment/payment_screen.dart';
// import 'package:food_prime_app/theme/style.dart';

// import '../../../../widgets/button_container_widget.dart';

// class CartPage extends StatelessWidget {
//   const CartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: whiteColor,
//         title: Image.asset("assets/word_app_logo.png"),
//       ),
//       body: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("2 items in the list cart", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 10,
//               itemBuilder: (context, index) {
//                 return _itemCartWidget(
//                     title: "Pizza",
//                     image: "pizza_popular_3.png",
//                     price: "23.4"
//                 );
//               })
//             ),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Items", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                 Text("2", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//               ],
//             ),
//             const SizedBox(height: 10,),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Delivery Fee", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                 Text("\$0.00", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//               ],
//             ),
//             const SizedBox(height: 10,),
//             Container(
//               width: double.infinity,
//               height: 1,
//               color: Colors.grey[350],
//             ),
//             const SizedBox(height: 10,),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Total", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                 Text("\$55.00", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//               ],
//             ),
//             const SizedBox(height: 30,),
//             ButtonContainerWidget(title: "Checkout", onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentScreen()));
//             },),
//             const SizedBox(height: 30,),
//           ],
//         ),
//       )
//     );
//   }

//   _itemCartWidget({String? title, String? price, String? image}) {
//     return Container(
//       width: double.infinity,
//       height: 110,
//       decoration: BoxDecoration(
//           color: whiteColor,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//                 offset: const Offset(0, 2),
//                 spreadRadius: 1.5,
//                 blurRadius: 6.5,
//                 color: Colors.grey[300]!
//             )
//           ]
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
//         child: Row(
//           children: [
//             Image.asset("assets/$image"),
//             const SizedBox(width: 10,),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("$title", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
//                       Container(
//                         width: 30,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: lightGreyColor,
//                         ),
//                         child: const Center(child: Icon(Icons.close, color: primaryColorED6E1B,),),
//                       )
//                     ],
//                   ),
//                   const Text("Times Food"),
//                   const SizedBox(height:5,),
//                    Text("\$$price", style: const TextStyle(fontWeight: FontWeight.w600),),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                         width: 30,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(width: 1),
//                         ),
//                         child: const Center(child: Icon(Icons.remove_outlined),),
//                       ),
//                       const SizedBox(width: 10,),
//                       const Text("1"),
//                       const SizedBox(width: 10,),
//                       Container(
//                         width: 30,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(width: 1),
//                         ),
//                         child: const Center(child: Icon(Icons.add),),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:food_prime_app/screens/payment/payment_screen.dart';
import 'package:food_prime_app/providers/cart_provider.dart'; // Import CartProvider

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("My Cart", style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "${cartProvider.cartItems.length} items in your cart",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              // Cart Item List
              Expanded(
                child: cartProvider.cartItems.isEmpty
                    ? const Center(child: Text("Your cart is empty"))
                    : ListView.builder(
                        itemCount: cartProvider.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartProvider.cartItems[index];
                          return _itemCartWidget(
                              context, cartProvider, index, item);
                        },
                      ),
              ),

              const Divider(),

              // Total & Checkout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(
                          "\$${cartProvider.totalPrice().toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: cartProvider.cartItems.isEmpty
                          ? null
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const PaymentScreen()));
                              cartProvider
                                  .clearCart(); // Clears cart after checkout
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Checkout successful!")));
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                      ),
                      child: const Text("Proceed to Checkout",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Individual Cart Item Widget
  Widget _itemCartWidget(BuildContext context, CartProvider cartProvider,
      int index, Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Item Image
            Image.asset("assets/${item['image']}",
                width: 80, height: 80, fit: BoxFit.cover),
            const SizedBox(width: 15),

            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title'],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Price: \$${item['price']}"),
                  Text("Quantity: ${item['quantity']}"),
                ],
              ),
            ),

            // Remove Button
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => cartProvider.removeFromCart(index),
            ),
          ],
        ),
      ),
    );
  }
}
