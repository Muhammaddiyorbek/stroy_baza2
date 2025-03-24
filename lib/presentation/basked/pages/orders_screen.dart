import 'package:flutter/material.dart';
import 'package:stroy_baza/app_constats/assets_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  static const routeName='/orders-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD1B07A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Buyurtmalar',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          _buildOrderItem(
            orderNumber: '63224636',
            status: 'Xaridorga Berilgan',
            statusColor: Colors.green,
            deliveryDate: 'Juma 10 yanvar',
            amount: '126.650 so\'m',
            showProduct: false,
          ),
          const Divider(),
          _buildOrderItem(
            orderNumber: '63224636',
            status: 'Jarayonda',
            statusColor: Colors.yellow,
            deliveryDate: 'Juma 10 yanvar',
            amount: '126.650 so\'m',
            showProduct: true,
            productName: 'PENOPLEX COMFORT',
            productPrice: '125.650 so\'m',
            installmentInfo: '1.999 so\'mdan /12oy',
          ),
          const Divider(),
          _buildOrderItem(
            orderNumber: '63224636',
            status: 'Qaytatilgan',
            statusColor: Colors.red,
            deliveryDate: 'Juma 10 yanvar',
            amount: '126.650 so\'m',
            showProduct: false,
          ),
        ],
      ),

    );
  }

  Widget _buildOrderItem({
    required String orderNumber,
    required String status,
    required Color statusColor,
    required String deliveryDate,
    required String amount,
    required bool showProduct,
    String? productName,
    String? productPrice,
    String? installmentInfo,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$orderNumber-sonli buyurtma',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Yetkazish sanasi'),
              Text(deliveryDate),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Rasmiylashtirish sanasi'),
              Text(deliveryDate),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('1 dona maxsulot'),
              Text(amount),
            ],
          ),
          if (showProduct) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Image.asset(
                  AssetsModel.penoplex,
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        productPrice!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          installmentInfo!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                showProduct ? 'Maxsulotni berkitish' : 'Maxsulotni ko\'rsatish',
                style: const TextStyle(
                  color: Color(0xFFD1B07A),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}