import 'package:flutter/material.dart';

class TitleWidget extends StatefulWidget {
  const TitleWidget({super.key, required this.titleController});
  final TextEditingController titleController;
  @override
  State<TitleWidget> createState() {
    return _TitleWidgetState();
  }
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.titleController,
      maxLength: 50,
      decoration: const InputDecoration(
        labelText: 'Title',
      ),
    );
  }
}
