
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({super.key});
  

  @override
  State<CustomDropdownButton> createState() {
    return _CustomDropdownButtonState();
  }
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  Category _selectedCategory = Category.leisure;



  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _selectedCategory,
      items: Category.values
          .map(
            (categorys) => DropdownMenuItem(
              value: categorys,
              child: Text(
                categorys.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: (valueEnum) {
        //si valueEnum es null el codigo llega hasta el return
        if (valueEnum == null) {
          return;
        }
        setState(() {
            _selectedCategory = valueEnum;
        });
      },
    );
  }
}
