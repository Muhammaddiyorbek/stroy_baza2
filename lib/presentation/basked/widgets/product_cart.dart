import 'package:flutter/material.dart';
import '../../../app_constats/assets_model.dart';
import 'quantity_button.dart';

class ProductCard extends StatelessWidget {
  final int index;
  final int quantity;
  final bool isSelected;
  final VoidCallback onSelectedChanged;
  final ValueChanged<int> onQuantityChanged;

  const ProductCard({
    super.key,
    required this.index,
    required this.quantity,
    required this.isSelected,
    required this.onSelectedChanged,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(AssetsModel.penoplex, fit: BoxFit.contain),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PENOPLEX COMFORT', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  const Text("O'lcham: 4x6   Rang: Ko'k"),
                  const Text('125.650 so\'m'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      QuantityButton(
                        icon: Icons.remove,
                        onTap: () {
                          if (quantity > 1) onQuantityChanged(quantity - 1);
                        },
                      ),
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(quantity.toString()),
                      ),
                      QuantityButton(
                        icon: Icons.add,
                        onTap: () => onQuantityChanged(quantity + 1),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onSelectedChanged,
              child: isSelected
                  ? const Icon(Icons.check_box_rounded, color: Color.fromRGBO(220, 195, 139, 1), size: 23)
                  : Container(
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(220, 195, 139, 1), width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 20),
      ],
    );
  }
}
