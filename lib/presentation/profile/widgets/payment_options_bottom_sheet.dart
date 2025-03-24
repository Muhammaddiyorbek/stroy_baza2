import 'package:flutter/material.dart';
import 'package:stroy_baza/app_constats/assets_model.dart';
import 'package:stroy_baza/presentation/basked/pages/orders_screen.dart';

class PaymentOptionsBottomSheet extends StatefulWidget {
  const PaymentOptionsBottomSheet({super.key});

  @override
  State<PaymentOptionsBottomSheet> createState() => _PaymentOptionsBottomSheetState();
}

class _PaymentOptionsBottomSheetState extends State<PaymentOptionsBottomSheet> {
  String selectedDuration = '12oy';
  String selectedProvider = 'Uzum';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add drag indicator
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "To'lov variantlari",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "To'lov muddati",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _buildDurationOption('Hammasi')),
                    const SizedBox(width: 10),
                    Expanded(child: _buildDurationOption('12oy')),
                    const SizedBox(width: 10),
                    Expanded(child: _buildDurationOption('24oy')),
                  ],
                ),
                const SizedBox(height: 20),
                _buildProviderOption(
                  'Alif',
                  '119.250 so\'m x 12oy',
                  AssetsModel.alif,
                ),
                const Divider(height: 1),
                _buildProviderOption(
                  'Solfy',
                  '119.250 so\'m x 12oy',
                  AssetsModel.solfy,
                ),
                const Divider(height: 1),
                _buildProviderOption(
                  'Anor',
                  '119.250 so\'m x 12oy',
                  AssetsModel.anor,
                ),
                const Divider(height: 1),
                _buildProviderOption(
                  'Uzum',
                  '119.250 so\'m x 12oy',
                  AssetsModel.uzum,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Jami',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '1.431.000so\'m',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showSuccessDialog();
                    },
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationOption(String duration) {
    bool isSelected = selectedDuration == duration;
    return InkWell(
      onTap: () => setState(() => selectedDuration = duration),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFFDEB887) : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? const Color(0xFFDEB887) : Colors.white,
        ),
        child: Text(
          duration,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildProviderOption(
    String name,
    String price,
    String icon,
  ) {
    bool isSelected = selectedProvider == name;
    return ListTile(
      onTap: () => setState(() => selectedProvider = name),
      leading: SizedBox(
        width: 40,
        height: 40,
        child: Image.asset(
          icon,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.account_balance_wallet,
              color: Colors.grey[400],
              size: 30,
            );
          },
        ),
      ),
      title: Text(name),
      subtitle: Text(price),
      trailing: Icon(
        isSelected ? Icons.check_circle : Icons.circle_outlined,
        color: const Color(0xFFDEB887),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Tanlovingiz uchun raxmat tez orada\noperatorlar siz bilan bog'lanishadi!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrdersScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD700),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Yopish',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
