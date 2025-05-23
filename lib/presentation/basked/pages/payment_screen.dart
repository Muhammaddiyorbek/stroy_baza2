import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stroy_baza/app_constats/assets_model.dart';
import 'package:stroy_baza/core/router/router.dart';
import 'package:stroy_baza/presentation/basked/pages/delivery_address_screen.dart';
import 'package:stroy_baza/presentation/basked/pages/user_agreement_screen.dart';
import 'package:stroy_baza/presentation/blocs/language_bloc/language_bloc.dart';
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
        elevation: 0,
        surfaceTintColor: const Color.fromRGBO(220, 195, 139, 1),
        backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: -15,
        title: const Text(
          "Buyurtma",
          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
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
      child: const Row(
        children: [
          Icon(Icons.person, color: Colors.grey, size: 35),
          SizedBox(width: 12),
          Column(
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
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PENOPLEX COMFORT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1.200.000 so\'m',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('1 dona'),
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
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryAddressScreen(),));
        },
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
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildPaymentMethod(0, 'Click', AssetsModel.click),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(height: 1),
          ),
          _buildPaymentMethod(1, 'Pay me', AssetsModel.payme),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(height: 1),
          ),
          _buildPaymentMethod(2, 'Qabul qilinganda', AssetsModel.qabul_qilganda),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(height: 1),
          ),
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
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700),),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: ElevatedButton(
          onPressed: _showPaymentOptions,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFDEB887),
            padding: const EdgeInsets.symmetric( vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Xaridni rasmiylashtirish',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            const Text(
              'Buyurtmani tasdiqlash orqali men ',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            GestureDetector(
              onTap: () {
                final currentLocale = context.read<LanguageBloc>().state.locale.languageCode;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserAgreementScreen(locale: currentLocale),
                  ),
                );
              },
              child: const Text(
                'foydalanuvchi shartnomasini',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Text(
              ' shartlarini qabul qilaman.',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
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
