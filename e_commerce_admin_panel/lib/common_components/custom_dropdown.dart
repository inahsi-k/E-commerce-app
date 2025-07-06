import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String hintText;
  final T? initialValue;
  final List<T> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final String Function(T) displayItem;
  const CustomDropdown({super.key, this.hintText='Select An Option', required this.onChanged, this.validator, required this.items, this.initialValue, required this.displayItem});

  @override
  Widget build(BuildContext context) {
    return  DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle:TextStyle(color: Colors.white),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        )
      ),
      value: initialValue,
      items: items.map((T item)=>DropdownMenuItem(value:item,child: Text(displayItem(item)))).toList(),
      onChanged:onChanged ,
      validator: validator,
    );
  }
}