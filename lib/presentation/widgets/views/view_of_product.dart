import 'package:flutter/material.dart';

// ItemOfProduct widget - individual product card
class ItemOfProduct extends StatelessWidget {
  final Map<String, dynamic> product;

  const ItemOfProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image with label
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product['image'],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            if (product['isNew'])
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),

        // Product name
        Text(
          product['name'],
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),

        // Price and rating row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Price
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 12, color: Colors.black),
                children: [
                  const TextSpan(text: 'Narxi: '),
                  TextSpan(
                    text: '${product['price']} UZS',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            // Rating and favorite
            Row(
              children: [
                // Star rating
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < product['rating'] ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 14,
                    );
                  }),
                ),
                const SizedBox(width: 6),
                // Heart icon
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 14,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ViewOfProduct widget - product grid layout
class ViewOfProduct extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ViewOfProduct({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF8E1), // Light amber background
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10, // 10px spacing between columns
          mainAxisSpacing: 16, // spacing between rows
        ),
        itemCount: products.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: ItemOfProduct(product: products[index]),
          );
        },
      ),
    );
  }
}

// Example usage
class ProductPage extends StatelessWidget {
  ProductPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> sampleProducts = [
    {
      'id': 1,
      'name': 'PENOPLEKS',
      'price': '9,999',
      'rating': 4,
      'isNew': true,
      'image': 'https://example.com/images/product1.jpg',
    },
    {
      'id': 2,
      'name': 'PENOPLEKS',
      'price': '9,999',
      'rating': 5,
      'isNew': true,
      'image': 'https://example.com/images/product2.jpg',
    },
    {
      'id': 3,
      'name': 'PENOPLEKS',
      'price': '9,999',
      'rating': 4,
      'isNew': true,
      'image': 'https://example.com/images/product3.jpg',
    },
    {
      'id': 4,
      'name': 'PENOPLEKS',
      'price': '9,999',
      'rating': 5,
      'isNew': false,
      'image': 'https://example.com/images/product4.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ViewOfProduct(products: sampleProducts),
    );
  }
}
