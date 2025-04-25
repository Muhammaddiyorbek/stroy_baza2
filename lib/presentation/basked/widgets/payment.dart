import 'package:flutter/material.dart';

class PaymentToggle extends StatefulWidget {
  final Function(bool) onChanged; // optional: bosilganda holatni tashqariga uzatish uchun

  const PaymentToggle({super.key, required this.onChanged});

  @override
  _PaymentToggleState createState() => _PaymentToggleState();
}

class _PaymentToggleState extends State<PaymentToggle> {
  bool isInstallmentSelected = false;

  void _toggle(bool value) {
    setState(() {
      isInstallmentSelected = value;
    });
    widget.onChanged(value); // tashqariga signal uzatish
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _toggle(false),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: !isInstallmentSelected ? Colors.black : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey,
                  width: !isInstallmentSelected ? 2.5 : 1,
                ),
              ),
              child: Center(
                child: Text(
                  "Hoziroq to'lash",
                  style: TextStyle(
                    color: !isInstallmentSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () => _toggle(true),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isInstallmentSelected ? Colors.black : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey,
                  width: isInstallmentSelected ? 2.5 : 1,
                ),
              ),
              child: Center(
                child: Text(
                  "Muddatli to'lov",
                  style: TextStyle(
                    color: isInstallmentSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
