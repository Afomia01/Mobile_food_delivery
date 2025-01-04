import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../providers/cart_provider.dart';

class FoodDetailPage extends StatefulWidget {
  final Map<String, dynamic> data; // Ensure dynamic type for data
  const FoodDetailPage({super.key, required this.data});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    // Ensure all values have a default non-null value
    final String title = widget.data['title'] ?? 'No Title';
    final String image = widget.data['image'] ??
        'default_image.png'; // Ensure a default image exists in assets
    final String rating = widget.data['rating']?.toString() ?? '0.0';
    final String priceString = widget.data['price']?.toString() ?? '0 Br';

    // Extract the numeric price
    final double price = _extractPrice(priceString);

    return Scaffold(
      bottomNavigationBar: _bottomWidget(title, image, price),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: Image.asset("assets/$image", fit: BoxFit.fill),
            ),
            const SizedBox(height: 15),
            _selectQuantityWidget(),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 5),
                    Text(rating),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Chicken breast, french fries, baked potato wedges."),
            const SizedBox(height: 15),
            const Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.orange),
                SizedBox(width: 10),
                Text("FREE delivery Sunday, October 23 2.00 PM"),
              ],
            ),
            const SizedBox(height: 15),
            const Row(
              children: [
                Icon(Icons.location_on, color: Colors.orange),
                SizedBox(width: 10),
                Text("Deliver to New York 10001"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectQuantityWidget() {
    return Center(
      child: Container(
        width: 130,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              spreadRadius: 1.5,
              blurRadius: 5.5,
              color: Colors.grey[400]!,
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
                onTap: _decrementQuantity,
                child: const Icon(Icons.remove_outlined)),
            const SizedBox(width: 10),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.orange, borderRadius: BorderRadius.circular(2)),
              child: Center(
                  child: Text("$_quantity",
                      style:
                          const TextStyle(fontSize: 15, color: Colors.white))),
            ),
            const SizedBox(width: 10),
            GestureDetector(
                onTap: _incrementQuantity, child: const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  Widget _bottomWidget(String title, String image, double price) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(5, -2),
                color: Colors.grey[300]!,
                spreadRadius: 1.5,
                blurRadius: 10,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total: ${(price * _quantity).toStringAsFixed(2)} Br",
                    style: const TextStyle(fontSize: 16)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    Map<String, dynamic> cartItem = {
                      'title': title,
                      'image': image,
                      'price': price.toStringAsFixed(2),
                      'quantity': _quantity,
                    };

                    cartProvider.addToCart(cartItem);

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Item added to cart")));

                    Navigator.pop(context);
                  },
                  child: const Text("Add to Cart",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double _extractPrice(String priceString) {
    final RegExp regExp = RegExp(r'\d+(\.\d+)?'); // Match numeric values
    final match = regExp.firstMatch(priceString);
    if (match != null) {
      return double.parse(match.group(0)!); // Convert matched value to double
    }
    return 0.0; // Default value if no match
  }
}
