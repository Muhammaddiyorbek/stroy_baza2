import 'package:flutter/material.dart';
import 'package:stroy_baza/app_constats/assets_model.dart';
import 'package:stroy_baza/presentation/pages/Region1.dart';
import 'package:stroy_baza/presentation/pages/payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;
  bool isInstallment = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFDEB887),
        title: const Text(
          'Savatcha',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hammasini tanlash',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.check_circle, color: Colors.amber[700]),
              ],
            ),
            const SizedBox(height: 16),
            _buildProductCard(),
            const Spacer(),
            _buildPaymentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              AssetsModel.penoplex,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'PENOPLEX COMFORT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.check_circle, color: Colors.amber[700]),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  '125.650 so\'m',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildQuantityButton(
                      icon: Icons.remove,
                      onTap: () {
                        if (quantity > 1) {
                          setState(() => quantity--);
                        }
                      },
                    ),
                    Container(
                      width: 40,
                      height: 32,
                      alignment: Alignment.center,
                      child: Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    _buildQuantityButton(
                      icon: Icons.add,
                      onTap: () => setState(() => quantity++),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Add payment type toggle
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isInstallment = false),
                    child: Container(
                      decoration: BoxDecoration(
                        color: !isInstallment ? Colors.white : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        border: !isInstallment
                            ? Border.all(color: Colors.grey.shade300)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Hoziroq to\'lash',
                        style: TextStyle(
                          color:
                              !isInstallment ? Colors.black : Colors.grey[600],
                          fontWeight: !isInstallment
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isInstallment = true),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isInstallment ? Colors.white : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        border: isInstallment
                            ? Border.all(color: Colors.grey.shade300)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Muddatli to\'lov',
                        style: TextStyle(
                          color:
                              isInstallment ? Colors.black : Colors.grey[600],
                          fontWeight: isInstallment
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('1 ta maxsulot'),
              Text('185.000 so\'m', style: TextStyle(color: Colors.grey[600])),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Siz buyurtmani 3 oydan 24 oygacha muddatli to\'lov evaziga xarid qilishingiz mumkin.',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Muddatli to\'lov',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '11 886 so\'mmdan x 24',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDEB887),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Rasmiylashtirish',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
