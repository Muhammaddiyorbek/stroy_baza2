import 'package:flutter/material.dart';
import 'package:stroy_baza/app_constats/assets_model.dart';
import 'package:stroy_baza/presentation/basked/pages/payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;
  bool isInstallment = false;
  String selectedText = 'Hoziroq';
  List<bool> selectedProducts = List.generate(5, (_) => false);
  bool isAllSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: const Color.fromRGBO(220, 195, 139, 1),
        backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
        title: const Text(
          'Savatcha',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
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
                        InkWell(
                          onTap: () {
                            setState(() {
                              isAllSelected = !isAllSelected;
                              for (int i = 0; i < selectedProducts.length; i++) {
                                selectedProducts[i] = isAllSelected;
                              }
                            });
                          },
                          child: isAllSelected
                              ? Icon(
                            Icons.check_box_rounded,
                            color: Color.fromRGBO(220, 195, 139, 1),
                            size: 23,
                          )
                              : Container(
                            width: 23,
                            height: 23,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromRGBO(220, 195, 139, 1),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _buildProductCard(index);
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildPaymentSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(int index) {
    return Column(
      children: [
        Row(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'PENOPLEX COMFORT',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "O'lcham: 4x6   Rang: Ko'k",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
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
                      Container(
                        height: 35,
                        width: 84,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedProducts[index] = !selectedProducts[index];
                        isAllSelected = selectedProducts.every((e) => e);
                      });
                    },
                    child: selectedProducts[index]
                        ? const Icon(
                      Icons.check_box_rounded,
                      color: Color.fromRGBO(220, 195, 139, 1),
                      size: 23,
                    )
                        : Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(220, 195, 139, 1),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(
            thickness: 1,
            color: Color.fromRGBO(228, 228, 225, 1),
          ),
        )
      ],
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon, size: 14),
    );
  }

  Widget _buildPaymentSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromRGBO(213, 213, 213, 1)),
      ),
      child: Column(
        children: [
          // Toggle section
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
                        border: !isInstallment ? Border.all(color: Colors.grey.shade300) : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Hoziroq to\'lash',
                        style: TextStyle(
                          color: !isInstallment ? Colors.black : Colors.grey[600],
                          fontWeight: !isInstallment ? FontWeight.w500 : FontWeight.normal,
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
                        border: isInstallment ? Border.all(color: Colors.grey.shade300) : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Muddatli to\'lov',
                        style: TextStyle(
                          color: isInstallment ? Colors.black : Colors.grey[600],
                          fontWeight: isInstallment ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          isInstallment ? const SizedBox(height: 10) : const SizedBox.shrink(),

          // Product count and total price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isInstallment ? '1 ta maxsulot' : "",
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text(isInstallment ? '185.000 so\'m' : "", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
            ],
          ),
          isInstallment ? const SizedBox(height: 10) : const SizedBox.shrink(),

          Text(
            isInstallment ? 'Siz buyurtmani 3 oydan 24 oygacha muddatli to\'lov evaziga xarid qilishingiz mumkin.' : "",
            style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.75), fontSize: 12),
          ),
          isInstallment ? const SizedBox(height: 30) : const SizedBox.shrink(),

          // TO'LOV TURIga mos TEXT QISMI
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isInstallment ? 'Muddatli to\'lov' : 'Umumiy: ',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Text(
                    isInstallment ? '11 886 so\'mdan' : '1 185.000 so\'m',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (isInstallment)
                    Text(
                      ' x 24',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),

          // Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(220, 195, 139, 1),
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
