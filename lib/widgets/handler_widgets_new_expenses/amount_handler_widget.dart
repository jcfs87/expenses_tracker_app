import 'package:flutter/material.dart';

class AmountWidget extends StatefulWidget {
  const AmountWidget({super.key, required this.amountController});
  final TextEditingController amountController;

  @override
  State<AmountWidget> createState() {
    return _AmountWidgetState();
  }
}

class _AmountWidgetState extends State<AmountWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixText: '\$ ',
        label: Text('Amount'),
      ),
    );
  }
}
