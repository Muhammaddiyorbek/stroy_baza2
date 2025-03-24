import 'package:flutter/material.dart';
import 'package:stroy_baza/app_constats/assets_model.dart';
import 'package:stroy_baza/presentation/profile/widgets/payment_options_bottom_sheet.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedPaymentMethod = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDEB887),
        leading: const BackButton(color: Colors.black),
        title: const Text('Buyurtma', style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Qabul qiluvchi'),
              _buildRecipientInfo(),
              _buildSectionTitle('Maxsulotlar soni, 1 dona'),
              _buildProductCard(),
              _buildSectionTitle('Qabul qilish usuli'),
              _buildDeliveryOptions(),
              _buildAddressSelection(),
              _buildCashbackCard(),
              _buildSectionTitle('To\'lov usuli'),
              _buildPaymentMethods(),
              _buildInstallmentDetails(),
              _buildSectionTitle('Sizning buyurtmangiz'),
              _buildOrderSummary(),
              const SizedBox(height: 20),
              _buildCheckoutButton(),
              _buildTermsAndConditions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRecipientInfo() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(Icons.person, color: Colors.grey, size: 35),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nuraliyev Muhammad Sodiq',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('+998 90 762 92 82'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Image.asset(AssetsModel.penoplex, height: 80),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PENOPLEX COMFORT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '1.200.000 so\'m',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('1 dona'),
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

  Widget _buildDeliveryOptions() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: const Text('Olib ketish'),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: const Text('Yetkazib berish'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSelection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(Icons.location_on, color: Colors.amber.shade700),
        title: const Text('Yetkazib berish manzilini tanlang'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }

  Widget _buildCashbackCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: const Icon(Icons.monetization_on_outlined, color: Colors.amber),
        title: const Text('Keshbekni ishlatish'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('15.000 UZS', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildPaymentMethod(0, 'Click', AssetsModel.click),
          const Divider(height: 1),
          _buildPaymentMethod(1, 'Pay me', AssetsModel.payme),
          const Divider(height: 1),
          _buildPaymentMethod(2, 'Qabul qilinganda', AssetsModel.qabul_qilganda),
          const Divider(height: 1),
          _buildPaymentMethod(3, 'Muddatli to\'lov', AssetsModel.mudatli_tolov),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(int index, String title, String icon) {
    return ListTile(
      onTap: () => setState(() => selectedPaymentMethod = index),
      leading: Image.asset(icon, width: 26),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Icon(
        selectedPaymentMethod == index ? Icons.check_circle : Icons.circle_outlined,
        color: const Color(0xFFDEB887),
      ),
    );
  }

  Widget _buildInstallmentDetails() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(AssetsModel.alif, height: 40),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Muddatli to\'lov turi'),
                      Text('Alif', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const Text('Taxrirlash', style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          const Divider(),
          _buildPaymentRow('Oylik to\'lov', '119,250 so\'m'),
          _buildPaymentRow('Muddatli to\'lov', '12oy'),
          _buildPaymentRow('Jami', '1,431,000so\'m'),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      children: [
        _buildPaymentRow('1 ta maxsulot narxi', '1,431,000so\'m'),
        _buildPaymentRow('Muddatli to\'lov', '12oy'),
        _buildPaymentRow('Muddatli to\'lov', '119,250so\'m'),
        const Divider(),
        _buildPaymentRow('Jami', '1,431,000so\'m', isBold: true),
      ],
    );
  }

  Widget _buildPaymentRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _showPaymentOptions,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDEB887),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Xaridni rasmiylashtirish',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(color: Colors.black87, fontSize: 12),
            children: [
              const TextSpan(text: 'Buyurtmani tasdiqlash orqali men '),
              TextSpan(
                text: 'foydalanuvchi shartnomasini',
                style: TextStyle(color: Colors.purple.shade700),
              ),
              const TextSpan(text: ' shartlarini qabul qilaman.'),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const PaymentOptionsBottomSheet(),
    );
  }
}
